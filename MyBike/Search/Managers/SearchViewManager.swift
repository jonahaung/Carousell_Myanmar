//
//  SearchViewManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 22/11/21.
//

import Foundation
import Combine
import SwiftUI

final class SearchViewManager: SearchTextObservable {
    
    @Published var searchMenu = SearchMenu.TitleSimilier
    @Published var categories = [Category]()
    @Published var category = Category.none
    @Published var condition = Item.Condition.none
    
    @Published var completionResults = [ItemViewModel]()
    @Published var finalResults = [ItemViewModel]()
    
    private let backend = Backend(20)
    private var isSearching = false
    
    override func onUpdateText(text: String) {
        if text.isEmpty {
            isSearching = false
            finalResults.removeAll()
            completionResults.removeAll()
        }
        if !isSearching {
            withAnimation {
                categories = Category.allValues.filter{ $0.title.lowercased().contains(searchText.lowercased()) }
                completionResults = AppBackendManager.shared.itemBackendManager(for: .suggessted).itemViewModels.filter{$0.item.title.lowercased().contains(searchText.lowercased())}
            }
        }
    }
    
    override func onUpdateTextDebounced(text: String) {
        guard !self.isSearching else { return }
        let menu = ItemMenu.search(searchMenu.queryFilter(for: searchText))
        Task {
            do {
                let items: [Item] = try await backend.load(for: menu)
                let itemViewModels = await backend.getItemViewModels(items: items)
                
                DispatchQueue.main.async {
                    guard !self.isSearching else { return }
                    
                    itemViewModels.reversed().forEach { result in
                        if !self.completionResults.contains(where: { x in
                            x.id == result.id
                        }) {
                            withAnimation {
                                self.completionResults.insert(result, at: 0)
                            }
                        }
                        
                    }
                }
            }catch (let error as APIService.APIError) {
                print(error.localizedDescription)
            }
        }
    }
    
    func search(_ itemMenu: ItemMenu) {
        isSearching = true
        completionResults.removeAll()
        categories.removeAll()
        Task {
            do {
                let items: [Item] = try await backend.load(for: itemMenu)
                let itemViewModels = await backend.getItemViewModels(items: items)
                DispatchQueue.main.async {
                    self.finalResults = itemViewModels
                }
            }catch (let error as APIService.APIError) {
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewManager {
    enum SearchMenu: String, CaseIterable, Identifiable {
        var id: String { return self.rawValue }
        
        case Title, TitleSimilier, Keywords, Person
        
        func queryFilter(for searchText: String) -> [SearchType] {
            switch self {
            case .Title:
                return [.Title(searchText)]
            case .TitleSimilier:
                return [.TitleSimilier(searchText)]
            case .Keywords:
                return [.Keywords([searchText])]
            case .Person:
                return []
            }
        }
    }
}

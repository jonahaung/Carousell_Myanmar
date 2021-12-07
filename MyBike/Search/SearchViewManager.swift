//
//  SearchViewManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 22/11/21.
//

import Foundation
import Combine

class SearchViewManager: SearchTextObservable {
    
    enum SearchFilter: String, CaseIterable, Identifiable {
        var id: SearchFilter { return self }
        case Title, Keywords, Person
    }
    
    @Published var searchFilter = SearchFilter.Title
    
    @Published var searchResults = [ItemViewModel]()
    @Published var category = Category.none
    @Published var condition = Item.Condition.none
    
    private let documentsPaginationLoader = DocumentsPaginationLoader(7)
    
    override func onUpdateText(text: String) {
        if text.isEmpty {
            searchResults.removeAll()
        }
    }
    
    override func onUpdateTextDebounced(text: String) {
        let menu: ItemMenu = {
            switch searchFilter {
            case .Title:
                return .search(.Title(text))
            case .Keywords:
                let words = text.components(separatedBy: .whitespaces)
                return .search(.Keywords(words))
            case .Person:
                return .search(.Seller(text))
            }
        }()
        Task {
            do {
                let items: [Item] = try await documentsPaginationLoader.load(for: menu, isSearching: true)
                DispatchQueue.main.async {
                    for item in items {
                        let itemViewModel = ItemViewModel(item: item)
                        self.searchResults.append(itemViewModel)
                    }
                }
            }catch (let error as APIService.APIError) {
                print(error.localizedDescription)
            }
        }
    }
    
    func search() {
        let words = searchText.lowercased().components(separatedBy: .whitespaces)
        Task {
            do {
                let items: [Item] = try await documentsPaginationLoader.load(for: .search(.Keywords(words)), isSearching: true)
                DispatchQueue.main.async {
                    for item in items {
                        let itemViewModel = ItemViewModel(item: item)
                        self.searchResults.append(itemViewModel)
                    }
                }
            }catch (let error as APIService.APIError) {
                print(error.localizedDescription)
            }
        }
    }
}

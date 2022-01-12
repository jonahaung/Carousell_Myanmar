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
    
    static let shared = SearchViewManager()
    
    @Published var searchContext = SearchContext()
    @Published var completionResults = [Item]()
    @Published var finalResults = [ItemViewModel]()
    
    private let backend = Backend()
    @Published var isSearching = false
    @Published var showFilters = false
    
    override func onUpdateText(text: String) async {
        if text.isEmpty {
            isSearching = false
            completionResults.removeAll()
        }
    }
    

    override func onUpdateTextDebounced(text: String) async {
        guard !self.isSearching else { return }
        isSearching = true
        let filters = searchContext.allAvailibleFilters(for: text)
        let menu = ItemMenu.search(filters)
        let items: [Item] = await backend.load(for: menu)
        
        items.forEach { item in
            if !self.completionResults.contains(where: { x in
                return x.id == item.id
            }) {
                withAnimation(.interactiveSpring()) {
                    if self.completionResults.count > 5 {
                        self.completionResults.removeLast()
                    }
                    self.completionResults.insert(item, at: 0)
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSearching = false
        }
    }
    
    @MainActor
    func search(_ itemMenu: ItemMenu) async {
        isSearching = true
        
        completionResults.removeAll()
        let items: [Item] = await backend.load(for: itemMenu)
        finalResults = await backend.getItemViewModels(items: items)
    }
    
    func resetAll() {
        AppAlertManager.shared.onComfirm(buttonText: "Comfirm Reset") {
            self.searchContext = SearchContext()
        }
    }
}


//
//  BikeListViewModel.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//
import Foundation
import Combine
import SwiftUI

class ItemsDatasource: ObservableObject, StringRepresentable {
    
    let itemMenu: ItemMenu
    private let backend = PaginationBackend()
    
    @Published var itemViewModels: [ItemViewModel] = []
    @Published var hasMoreData = true
    @Published var hasLoaded = false
    @Published var isLoading = false
    
    init(_ itemMenu: ItemMenu) {
        self.itemMenu = itemMenu
    }
    
}

extension ItemsDatasource {
    
    @MainActor
    private func loadData() async {
        guard hasMoreData && !isLoading else { return }
        isLoading = true
        
        let results: [Item]? = await backend.load(for: itemMenu)
        
        let items = results ?? []
    
        var newViewModels = await backend.getItemViewModels(items: items)
        newViewModels = newViewModels.sortedMoviesIds(by: itemMenu.itemSort)
        
        hasMoreData = AppUserDefault.shared.maxQueryLimit == newViewModels.count
        
        if !hasLoaded {
            hasLoaded = true
            itemViewModels.removeAll()
        }
        
        itemViewModels += newViewModels
        
        self.isLoading = false
    }
}


extension ItemsDatasource {
    
    func fetchData() async {
        if !hasLoaded {
            await loadData()
        }
    }
    
    func resetData() async {
        guard !isLoading else { return }
        hasMoreData = true
        hasLoaded = false
        backend.reset()

        try? await Task.sleep(nanoseconds: 2_000_000_000)
        await fetchData()
    }
    
    func loadMoreIfNeeded() async {
        await Task.sleep(2_000_000_000)
        await loadData()
    }
}

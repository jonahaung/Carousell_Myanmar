//
//  BikeListViewModel.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//
import Foundation
import Combine
import SwiftUI

class ItemsDatasource: ObservableObject {
    
    private let itemMenu: ItemMenu
    
    @Published var itemViewModels: [ItemViewModel] = ItemViewModel.getMockData(for: 10)
    
    @Published var hasMoreData = true
    @Published var hasLoaded = false
    @Published var isLoading = false
    private var task: Task<(), Error>?
    
    private let backend = PaginationBackend(6)
    
    init(_ itemMenu: ItemMenu) {
        self.itemMenu = itemMenu
    }
    
    deinit{
        task?.cancel()
        print("Deinit")
    }
}

extension ItemsDatasource {
    
    func loadData() {
        guard hasMoreData && !isLoading else { return }
        isLoading = true
        task?.cancel()
        task = Task {
            do {
                let items: [Item] = try await backend.load(for: itemMenu)
                let itemViewModels = await backend.getItemViewModels(items: items)
                
                DispatchQueue.main.async {
                    if !self.hasLoaded {
                        self.itemViewModels.removeAll()
                        self.hasLoaded = true
                    }
                    self.itemViewModels += itemViewModels
                    self.hasMoreData = self.backend.limit == items.count
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.isLoading = false
                    }
                }
            }catch (let error as APIService.APIError) {
                DispatchQueue.main.async {
                    switch error {
                    case .noMoreData:
                        self.hasMoreData = false
                        print("no more data")
                    case .decodingError:
                        print("decoding error")
                    }
                    self.isLoading = false
                }
            }
        }
        
    }
}


extension ItemsDatasource {
    
    func fetchData() {
        if !hasLoaded {
            loadData()
        }
    }
    
    func resetData() {
        isLoading = false
        hasLoaded = false
        hasMoreData = true
        backend.reset()
        fetchData()
    }
}

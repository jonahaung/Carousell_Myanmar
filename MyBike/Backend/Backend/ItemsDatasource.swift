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
    
    let itemMenu: ItemMenu
    
    @Published var itemViewModels: [ItemViewModel] = ItemViewModel.getMockData(for: 10)
    @Published var errorAlert: AlertObject = AlertObject(buttonText: "", show: false)
    
    @Published var hasMoreData = true
    @Published var hasLoaded = false
    
    var isLoading = false
    private let backend = PaginationBackend(4)
    
    init(_ itemMenu: ItemMenu) {
        self.itemMenu = itemMenu
    }
    
    @MainActor
    func loadData() {
        guard hasMoreData && !isLoading else { return }
        isLoading = true
        Task {
            do {
                let items: [Item] = try await backend.load(for: itemMenu)
                if !self.hasLoaded {
                    self.itemViewModels.removeAll()
                    self.hasLoaded = true
                }
                
                let new = items.map(ItemViewModel.init)
                self.itemViewModels += new
                self.hasMoreData = self.backend.limit == items.count
            }catch (let error as APIService.APIError) {
                switch error {
                case .noMoreData:
                    self.hasMoreData = false
                default:
                    self.errorAlert = AlertObject(error.localizedDescription)
                }
            }
            self.isLoading = false
        }
    }
    
    deinit{
        print("\(self)")
    }
    
    func resetData() {
        backend.reset()
        isLoading = false
        hasLoaded = false
        hasMoreData = true
        itemViewModels.removeAll()
        
        Task {
            await self.loadData()
        }
    }
}

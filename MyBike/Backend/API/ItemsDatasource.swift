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
    
    @Published var itemViewModels: [ItemViewModel] = ItemViewModel.getMockData(for: 8)
    @Published var errorAlert: AlertObject?
    
    @Published var hasMoreData = true
    @Published var hasLoaded = false
    
    private var isLoading = false
    
    private let documentsPaginationLoader = DocumentsPaginationLoader(10)
    
    init(_ itemMenu: ItemMenu) {
        self.itemMenu = itemMenu
        print("init")
    }
    
    @MainActor
    func loadData() {
        guard hasMoreData && !isLoading else { return }
        isLoading = true
        
        Task { [weak self] in
            do {
                let items: [Item] = try await documentsPaginationLoader.load(for: itemMenu)
                guard let self = self else { return }
                if !self.hasLoaded {
                    self.itemViewModels.removeAll()
                    self.hasLoaded = true
                }
                self.itemViewModels += items.map(ItemViewModel.init)
                self.hasMoreData = self.documentsPaginationLoader.limit == items.count
            }catch (let error as APIService.APIError) {
                switch error {
                case .noMoreData:
                    self?.hasMoreData = false
                default:
                    self?.errorAlert = AlertObject(title: error.localizedDescription)
                }
            }
            self?.isLoading = false
        }
    }
    
    deinit{
        print("Deinit")
    }
    @MainActor func fetchData() {
        if !hasLoaded {
            loadData()
        }
    }
    
    @MainActor func resetData() {
        isLoading = false
        hasLoaded = false
        hasMoreData = true
        documentsPaginationLoader.reset()
        fetchData()
    }
}


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
    
    @Published var itemViewModels: [ItemViewModel] = ItemViewModel.getMockData(for: 6)
    @Published var errorAlert: AlertObject = AlertObject(buttonText: "", show: false)
    
    @Published var hasMoreData = true
    @Published var hasLoaded = false
    @Published var isLoading = false
    
    private let backend = PaginationBackend(6)
    
    init(_ itemMenu: ItemMenu) {
        self.itemMenu = itemMenu
    }
    
    deinit{
        print("Deinit")
    }
}

extension ItemsDatasource {
    
    func loadData() {
        guard hasMoreData && !isLoading else { return }
        isLoading = true
        
        Task { [ weak self] in
            do {
                let items: [Item] = try await backend.load(for: itemMenu)
                let itemViewModels = await backend.getItemViewModels(items: items)
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if !self.hasLoaded {
                        self.itemViewModels.removeAll()
                        self.hasLoaded = true
                    }
                    self.itemViewModels += itemViewModels
                    self.hasMoreData = self.backend.limit == items.count
                    self.isLoading = false
                }
            }catch (let error as APIService.APIError) {
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch error {
                    case .noMoreData:
                        self.hasMoreData = false
                    default:
                        self.errorAlert = AlertObject(error.localizedDescription)
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
        loadData()
    }
}

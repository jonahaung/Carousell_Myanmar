//
//  AppBackendManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 23/11/21.
//

import Foundation
import SwiftUI

class AppBackendManager: ObservableObject {
    
    static let shared = AppBackendManager()
    
    let homeMenus = [ItemMenu.suggessted, .popular, .mostViewed, .category]
    
    private var itemsBackendManagers = [ItemMenu: ItemsDatasource]()
    
    func itemBackendManager(for itemMenu: ItemMenu) -> ItemsDatasource {
        if let x = itemsBackendManagers[itemMenu] {
            return x
        } else {
            let x = ItemsDatasource(itemMenu)
            itemsBackendManagers[itemMenu] = x
            return x
        }
    }
    
    @MainActor
    func refreshAllData() {
        homeMenus.forEach{
            itemBackendManager(for: $0).resetData()
        }
        ImageLoaderCache.shared.loaders.removeAllObjects()
    }
}

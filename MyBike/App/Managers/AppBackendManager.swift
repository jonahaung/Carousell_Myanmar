//
//  AppBackendManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 23/11/21.
//

import Foundation
import SwiftUI

private class ItemDatasourceCache {
    
    static let shared = ItemDatasourceCache()
    
    private var cache = [ItemMenu: ItemsDatasource]()
    
    func loaderFor(itemMenu: ItemMenu) -> ItemsDatasource {
        if let x = cache[itemMenu] {
            return x
        }
        let x = ItemsDatasource(itemMenu)
        cache.updateValue(x, forKey: itemMenu)
        return x
    }
    
    var allDatasources: [ItemsDatasource] { cache.map{$0.value} }
}

final class AppBackendManager: ObservableObject {
    
    static let shared = AppBackendManager()
    
    func itemBackendManager(for itemMenu: ItemMenu) -> ItemsDatasource {
        
        guard AppUserDefault.shared.isCachedForLocalData else {
            return ItemsDatasource(itemMenu)
        }
        return ItemDatasourceCache.shared.loaderFor(itemMenu: itemMenu)
    }
    
    var datasourceCount: Int { ItemDatasourceCache.shared.allDatasources.count }
    
    func refreshAllData(_ done: @escaping (() -> Void) = {}) {
//        ItemDatasourceCache.shared.allDatasources.forEach{
//            $0.resetData()
//        }
        done()
    }
    
    func refresh(_ item: Item) {
        Task {
            await ItemStore.shared.storage.values.forEach { old in
                if old.id == item.id {
                    DispatchQueue.main.async {
                        old.item = item
                    }
                }
            }
        }
    }
}

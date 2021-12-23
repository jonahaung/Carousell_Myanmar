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
    
    private var itemDatasources = [ItemMenu: ItemsDatasource]()
    
    func itemBackendManager(for itemMenu: ItemMenu) -> ItemsDatasource {
        guard UserDefaultManager.shared.isCachedItem else {
            return ItemsDatasource(itemMenu)
        }
        if let x = itemDatasources[itemMenu] {
            return x
        }
        let x = ItemsDatasource(itemMenu)
        itemDatasources[itemMenu] = x
        return x
    }
    
    func refreshAllData(_ done: @escaping (() -> Void) = {}) {
        self.itemDatasources.map{$0.value}.forEach{
            $0.resetData()
        }
        done()
    }
    
    func refresh(_ item: Item) {
        itemDatasources.forEach { dic in
            let olds = dic.value.itemViewModels
            olds.forEach { old in
                if old.id == item.id {
                    old.item = item
                }
            }
        }
    }
}

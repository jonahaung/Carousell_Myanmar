//
//  BikeViewModel.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import Foundation

actor ItemStore {
    
    static let shared = ItemStore()
    var storage = [String: ItemViewModel]()
    
    func getModel(for item: Item) -> ItemViewModel? {
        guard AppUserDefault.shared.isCachedForRemoteData else { return nil }
        guard let id = item.id else { return nil }
        return storage[id]
    }
    func addModel(itemViewModel: ItemViewModel) {
        guard AppUserDefault.shared.isCachedForRemoteData else { return }
        storage[itemViewModel.id] = itemViewModel
    }
   
    func count() -> Int {
        storage.count
    }
}

class ItemViewModel: ObservableObject, Identifiable {
    
    var id: String { item.id ?? "Item"  }

    @Published var item: Item
    @Published var person: Person
    
    init(item: Item, person: Person) {
        self.item = item
        self.person = person
    }
}

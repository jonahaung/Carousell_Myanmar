//
//  SearchBackend.swift
//  MyBike
//
//  Created by Aung Ko Min on 8/12/21.
//

import FirebaseFirestore

class Backend {
    
   
    internal let limit = AppUserDefault.shared.maxQueryLimit
    
    internal func collectionRef(for T: Codable.Type) -> Query {
        let path = T.self == Item.self ? "bikes" : "persons"
        let query: Query = Firestore.firestore().collection(path)
        return query.limit(to: limit)
    }
    
    func load<T: Codable>(for menu: ItemMenu) async -> [T] {
        let query: Query = {
            var query = collectionRef(for: T.self)
            menu.configureQueryForDatasource(for: &query)
            return query
        }()
        
        let result: APIService.APIResult<T>? = try? await APIService.shared.GET(query: query)
        return result?.results ?? []
    }
    
    func getItemViewModels(items: [Item]) async -> [ItemViewModel] {
        
        return await withTaskGroup(of: ItemViewModel?.self) { group in
            var itemViewModels = [ItemViewModel?]()
            itemViewModels.reserveCapacity(items.count)
            
            for item in items {
                group.addTask {
                    if let old = await ItemStore.shared.getModel(for: item) {
                        return old
                    }
                    if let person = try? await item.seller.getPerson() {
                        let itemViewModel = ItemViewModel(item: item, person: person)
                        await ItemStore.shared.addModel(itemViewModel: itemViewModel)
                        return itemViewModel
                    }
                    return nil
                }
            }
            
            for await x in group {
                itemViewModels.append(x)
            }
            return itemViewModels.compactMap{$0}
        }
        
    }
}

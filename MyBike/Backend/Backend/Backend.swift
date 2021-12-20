//
//  SearchBackend.swift
//  MyBike
//
//  Created by Aung Ko Min on 8/12/21.
//

import FirebaseFirestore

class Backend {
    
    internal let limit: Int
    
    init(_ limit: Int) {
        self.limit = limit
    }
    
    internal func collectionRef(for T: Codable.Type) -> Query {
        let path = T.self == Item.self ? "bikes" : "persons"
        let query: Query = Firestore.firestore().collection(path).limit(to: limit)
        return query
    }
    
    func load<T: Codable>(for menu: ItemMenu) async throws -> [T] {
        let query: Query = {
            var query = collectionRef(for: T.self)
            menu.apply(for: &query)
            return query
        }()
        
        let result: APIService.APIResult<T> = try await APIService.shared.GET(query: query)
        return result.results
    }
    
    func getItemViewModels(items: [Item]) async -> [ItemViewModel] {
        var itemViewModels = [ItemViewModel?]()
        await withTaskGroup(of: ItemViewModel?.self) { group in
            for x in items {
                group.addTask {
                    if let person = try? await x.seller.getPerson() {
                        return ItemViewModel(item: x, person: person)
                    }
                    return nil
                }
            }
            
            for await x in group {
                itemViewModels.append(x)
            }
        }
        return itemViewModels.compactMap{$0}
    }
}

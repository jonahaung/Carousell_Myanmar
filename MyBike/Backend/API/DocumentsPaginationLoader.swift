//
//  BikesPagnitionManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/11/21.
//

import Foundation
import FirebaseFirestore

final class DocumentsPaginationLoader {
    
    private let collectionReference = Firestore.firestore().collection(AppData.shared.items)
    private var nextQuery: Query?
    let limit: Int
    
    init(_ limit: Int) {
        self.limit = limit
    }
    
    func load<T: Codable>(for menu: ItemMenu, isSearching: Bool = false) async throws -> [T] {
        
        if isSearching { nextQuery = nil }
        
        let query: Query = {
            if let query = nextQuery {
                return query
            }else {
                return collectionReference
                    .searchQuery(menu: menu)
                    .orderByQuery(menu: menu)
                    .limit(to: limit)
            }
        }()
        
        let result: APIService.APIResult<T> = try await APIService.shared.GET(query: query)
        self.nextQuery = result.nextQuery
        return result.results
    }
    
    func reset() {
        nextQuery = nil
    }
}

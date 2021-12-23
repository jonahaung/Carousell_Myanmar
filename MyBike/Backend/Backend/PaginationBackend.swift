//
//  BikesPagnitionManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/11/21.
//

import Foundation
import FirebaseFirestore

final class PaginationBackend: Backend {
    
    private var nextQuery: Query?
    
    override func load<T>(for menu: ItemMenu) async throws -> [T] where T : Decodable, T : Encodable {
        let query: Query = {
            if let query = nextQuery {
                return query
            }else {
                var query = collectionRef(for: T.self)
                menu.apply(for: &query)
                return query.limit(to: limit)
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

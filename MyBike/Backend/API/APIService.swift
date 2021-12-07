//
//  APIService.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 06/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct APIService {
    
    enum APIError: Error {
        case noMoreData, decodingError
        
        var description: String {
            switch self {
            case .noMoreData: return "No More Data"
            case .decodingError: return "Json Decoding Error"
            }
        }
    }
    
    typealias APIResult<T> = (results: [T], nextQuery: Query?)
    
    static let shared = APIService()
    
    func GET<T: Codable>(query: Query) async throws -> APIResult<T> {
        
        let snapshot = try await query.getDocuments()
        
        guard let lastDocument = snapshot.documents.last else {
            throw APIService.APIError.noMoreData
        }
        
        let items = snapshot.documents.compactMap { document in
            try? document.data(as: T.self)
        }
        
        guard !items.isEmpty else {
            throw APIError.decodingError
        }
        let nextQuery = query.start(afterDocument: lastDocument)
        
        return APIResult(items, nextQuery)
    }
}

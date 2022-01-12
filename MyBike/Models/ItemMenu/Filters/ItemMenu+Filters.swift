//
//  ItemMenu+Filters.swift
//  MyBike
//
//  Created by Aung Ko Min on 5/1/22.
//

import Firebase

extension ItemMenu {

    
    func configureQueryForDatasource(for query: inout Query) {
        
        switch self {
        case .Recents:
            query = query.order(by: "dateAdded", descending: true)
        case .Popular:
            query = query
                .order(by: "favourites.count", descending: true)
        case .MostView:
            query = query
                .order(by: "views.count", descending: true)
        case .MyFavourites(let uid):
            query = query
                .whereField("favourites.uids", arrayContains: uid)
        case .MySeenItems(let uid):
            query = query
                .whereField("views.uids", arrayContains: uid)
        case .search(let searchTypes):
            searchTypes.forEach{
                $0.configureQueryForDatasource(for: &query)
            }
        case .ViewedCategory(let viewHistory):
            guard !viewHistory.categories.isEmpty else { break }
            let titles = viewHistory.categories.map{$0.title}
            query = query
                .whereField("category.title", in: titles)
        default:
            break
        }

    }
}

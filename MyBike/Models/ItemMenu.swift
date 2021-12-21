//
//  BikeMenu.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import Foundation
import FirebaseFirestore

enum ItemMenu {

    case suggessted, popular, mostViewed, favourites, seenItems, category
    case search([SearchType])
}

extension ItemMenu {
    var title: String {
        switch self {
        case .suggessted:
            return "Suggessted"
        case .popular:
            return "Popular"
        case .mostViewed:
            return "Most Viewed"
        case .category:
            return "Category"
        case .favourites:
            return "Favourites"
        case .seenItems:
            return "Seen"
        case .search(let searchType):
            return searchType.map{$0.description}.joined(separator: " ")
        }
    }
}

extension ItemMenu {
    
    func apply(for query: inout Query) {
        switch self {
        case .suggessted:
            query = query.order(by: "dateAdded", descending: true)
        case .popular:
            query = query.order(by: "favourites.count", descending: true)
        case .mostViewed:
            query = query.order(by: "views.count", descending: true)
        case .favourites:
            if let uid = AuthenticationService.shared.currentUserViewModel?.id {
                query = query.whereField("favourites.uids", arrayContains: uid)
            }
        case .seenItems:
            if let uid = AuthenticationService.shared.currentUserViewModel?.id {
                query = query.whereField("views.uids", arrayContains: uid)
            }
        case .category:
            break
        case .search(let searchTypes):
            searchTypes.forEach{
                $0.apply(for: &query)
            }
        }
    }
}

extension ItemMenu: Identifiable {
    var id: String { return title }
}

extension ItemMenu: Equatable, Hashable {

    func hash(into hasher: inout Hasher) {
        switch self {
        case .search(let searchType):
            hasher.combine(searchType.map{ $0.id }.joined())
        default:
            hasher.combine(title)
        }
    }
}

//
//  QueryExtensions.swift
//  MyBike
//
//  Created by Aung Ko Min on 18/11/21.
//

import Firebase
import FirebaseFirestore

extension Query {
    
    func orderByQuery(menu: ItemMenu) -> Query {
        switch menu {
        case .suggessted:
            return self.order(by: "dateAdded", descending: true)
        case .popular:
            return self.order(by: "favourites.count", descending: true)
        case .mostViewed:
            return self.order(by: "views.count", descending: true)
        default:
            return self
        }
    }
    
    func searchQuery(menu: ItemMenu) -> Query {
        switch menu {
        case .favourites:
            return self.whereField("favourites.uids", arrayContains: Auth.auth().currentUser?.uid ?? "")
        case .seenItems:
            return self.whereField("views.uids", arrayContains: Auth.auth().currentUser?.uid ?? "")
        case  .search(let searchType):
            switch searchType {
            case .Address(let addressType):
                switch addressType {
                case .state(let string):
                    return self.whereField("address.state", isEqualTo: string)
                case .township(let string):
                    return self.whereField("address.township", isEqualTo: string)
                }
            case .UserItem(let person):
                return self.whereField("seller.userName", isGreaterThanOrEqualTo: person.userName.lowercased())
            case .Title(let string):
                return self.whereField("title", isGreaterThanOrEqualTo: string.lowercased())
            case .Keywords(let keywords):
                return self.whereField("keywords", arrayContainsAny: keywords.map{$0.lowercased()})
            case .Category(let category):
                return self.whereField("category.title", isEqualTo: category.title)
            case .Condition(let itemCondition):
                return self.whereField("condition", isEqualTo: itemCondition.rawValue)
            case .Seller(let string):
                return self.whereField("seller.userName", isEqualTo: string.lowercased())
            case .Similier(let item):
                return self.whereField("category.title", isEqualTo: item.category.title).whereField("keywords", arrayContainsAny: item.keywords.map{$0.lowercased()})
                
            }
        default:
            return self
        }
    }
}

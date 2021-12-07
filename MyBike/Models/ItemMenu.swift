//
//  BikeMenu.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import Foundation
import Firebase
import FirebaseFirestore

enum ItemMenu: Identifiable {
    
    enum SearchType: Hashable, Equatable {
        
        enum AddressType {
            case state(String)
            case township(String)
            
            var description: String {
                switch self {
                case .state(let string):
                    return string
                case .township(let string):
                    return string
                }
            }
        }
        static func == (lhs: ItemMenu.SearchType, rhs: ItemMenu.SearchType) -> Bool {
            return lhs.description == rhs.description
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(description)
        }
        
        case Title(String)
        case Keywords([String])
        case Category(Category)
        case Condition(Item.Condition)
        case Seller(String)
        case UserItem(Person)
        case Similier(Item)
        case Address(AddressType)
        
        var description: String {
            switch self {
            case .Title(let string):
                return string.uppercased()
            case .Keywords(_):
                return "keywords"
            case .Category(let category):
                return category.title.uppercased()
            case .Condition(let condition):
                return condition.description
            case .Seller(let string):
                return "more from \(string)"
            case .UserItem(let person):
                return person.userName
            case .Similier(_):
                return "Similier Items"
            case .Address(let type):
                return type.description
            }
        }
    }
    

    var id: ItemMenu { return self }
    
    case suggessted, popular, mostViewed, favourites, seenItems, category
    case search(SearchType)
    
    func title() -> String {
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
            return searchType.description
        }
    }
}

extension ItemMenu: Equatable { }

extension ItemMenu: Hashable {

    func hash(into hasher: inout Hasher) {
        switch self {
        case .search(let searchType):
            hasher.combine(searchType.description)
        default:
            break
        }
    }
}

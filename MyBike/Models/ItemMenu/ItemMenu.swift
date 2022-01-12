//
//  BikeMenu.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import Foundation

enum ItemMenu: UIElementRepresentable {
    
    case Recents, Popular, MostView, Category
    case MySeenItems(_ uid: String)
    case MyFavourites(_ uid: String)
    case search([SearchFilter])
    case ViewedCategory(Person.ViewedHistory)
    
}

extension ItemMenu: Hashable {
    
    static func == (lhs: ItemMenu, rhs: ItemMenu) -> Bool {
        return lhs.description == rhs.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
}

extension ItemMenu {
    
    var description: String {
        switch self {
        case .search(let searchType):
            return searchType.map{$0.description}.joined(separator: " ")
        case .ViewedCategory(let viewHistory):
            return "Viewed Categories \(viewHistory.categories.count)"
        default:
            return stringValue
        }
    }

    var title: String {
        switch self {
        case .search(let searchType):
            return searchType.map{$0.title}.joined(separator: " ")
        case .ViewedCategory(_):
            return "Viewed Categories"
        default:
            return stringValue
        }
    }
    
    var itemSort: ItemSort {
        switch self {
        case .Recents:
            return .byAddedDate
        case .Popular:
            return .byPopularity
        case .MostView:
            return .byViews
        case .Category:
            return .byAddedDate
        case .MySeenItems(_):
            return .byAddedDate
        case .MyFavourites(_):
            return .byAddedDate
        case .search(_):
            return .byAddedDate
        case .ViewedCategory(_):
            return .byAddedDate
        }
    }
    
    static let homeMenus: [ItemMenu] = [.Recents, .Popular, .MostView]
}

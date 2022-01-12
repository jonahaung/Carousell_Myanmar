//
//  Collection.swift
//  MyBike
//
//  Created by Aung Ko Min on 9/1/22.
//

import Foundation


enum ItemSort {
    case byAddedDate, byViews, byPopularity
    
    func title() -> String {
        switch self {
        
        case .byAddedDate:
            return "by added date"
        case .byViews:
            return "by rating"
        case .byPopularity:
            return "by popularity"
        }
    }
    
    func sortByAPI() -> String {
        switch self {
    
        case .byAddedDate:
            return "primary_release_date.desc"
        case .byViews:
            return "vote_average.desc"
        case .byPopularity:
            return "popularity.desc"
        }
    }
}

extension Sequence where Iterator.Element == ItemViewModel {
    func sortedMoviesIds(by: ItemSort) -> [ItemViewModel]{
        switch by {
        case .byAddedDate:
            
            return self.sorted { one, two in
                return one.item.dateAdded > two.item.dateAdded
            }
        case .byPopularity:
            return self.sorted { one, two in
                return one.item.favourites.count > two.item.favourites.count
            }
        case .byViews:
            return self.sorted { one, two in
                return one.item.views.count > two.item.views.count
            }
        }
    }
}

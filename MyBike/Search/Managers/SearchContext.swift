//
//  SearchContext.swift
//  MyBike
//
//  Created by Aung Ko Min on 25/12/21.
//

import Foundation
import SwiftUI

extension SearchViewManager {
    
    class SearchContext: ObservableObject {

        @Published var address = Item.Address.none
        @Published var category = Category.none
        @Published var dealingType = Item.ExchangeType.Sell
        @Published var condition = Item.Condition.None
        @Published var price: Range<Double>?
        
        @Published var searchObjectType = SearchObjectType.Item
        @Published var searchTextType = SearchTextType.Name_Similier
        
        func allAvailibleFilters(for text: String) -> [SearchFilter] {
            var filter = [SearchFilter]()
            
            if !address.isEmpty {
                filter.append(.Address(.state(address.state)))
            }
            if category.isSelected {
                filter.append(.Category(category))
            }
            
            if condition.isSelected {
                filter.append(.Condition(condition))
            }
            return filter + searchTextType.queryFilter(for: text, wit: searchObjectType)
        }
        
        var isEmpty: Bool {
            address.isEmpty && category.isEmpty && condition.isEmpty && price == nil
        }
        
    }

}

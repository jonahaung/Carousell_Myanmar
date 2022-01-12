//
//  SearchObjectType.swift
//  MyBike
//
//  Created by Aung Ko Min on 25/12/21.
//

import Foundation

enum SearchObjectType: Hashable, CaseIterable {
    
    var id: String { title }
    
    case Item, Person
    
    var title: String {
        switch self {
        case .Item:
            return "Item"
        case .Person:
            return "Person"
        }
    }
}

enum SearchTextType: CaseIterable, Identifiable {
    
    var id: String { description }
    
    case Name, Name_Similier
    
    var description: String {
        switch self {
        case .Name:
            return "Names"
        case .Name_Similier:
            return "Similiter Names"
        }
    }
    
    func queryFilter(for text: String, wit objectType: SearchObjectType) -> [SearchFilter] {
        
        if objectType == .Item {
            switch self {
            case .Name:
                return [.Title(.Full(title: text))]
            case .Name_Similier:
                return [.Title(.Similier(title: text))]
            }
        } else {
            switch self {
            case .Name:
                return []
            case .Name_Similier:
                return []
            }
        }
    }
}

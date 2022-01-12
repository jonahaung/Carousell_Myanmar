//
//  SearchType.swift
//  MyBike
//
//  Created by Aung Ko Min on 8/12/21.
//

import Foundation
import FirebaseFirestore

enum SearchFilter {
    
    case Title(TitleType)
    case Keywords([String])
    case Category(Category)
    case Condition(Item.Condition)
    case Person(uid: String)
    case Item_Similier(Item)
    case Address(AddressType)
    
}

extension SearchFilter {
    
    enum TitleType {
        case Full(title: String)
        case Similier(title: String)
    }
    
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
}

extension SearchFilter {
    
    func configureQueryForDatasource(for query: inout Query) {
        switch self {
        case .Title(let titleType):
            switch titleType {
            case .Full(let title):
                query = query.whereField("title", isEqualTo: title.lowercased())
            case .Similier(let title):
                let string = title.lowercased()
                query = query.whereField("title", isGreaterThanOrEqualTo: string)
                    .whereField("title", isLessThanOrEqualTo: string + "~")
            }
        case .Keywords(var strings):
            strings = strings.map{$0.lowercased()}.unique
            query = query.whereField("keywords", arrayContainsAny: strings)
        case .Category(let category):
            query = query.whereField("category.title", isEqualTo: category.title)
        case .Condition(let condition):
            query = query.whereField("condition", isEqualTo: condition.rawValue)
        case .Person(let uid):
            query = query.whereField("seller.id", in: [uid])
        case .Item_Similier(let item):
            query = query.whereField("category.title", isEqualTo: item.category.title).whereField("keywords", arrayContainsAny: item.keywords.map{$0.lowercased()})
        case .Address(let addressType):
            switch addressType {
            case .state(let string):
                query = query.whereField("address.state", isEqualTo: string)
            case .township(let string):
                query = query.whereField("address.township", isEqualTo: string)
            }
        }
    }
}

extension SearchFilter {
    
    var description: String {
        switch self {
        case .Title(let titleType):
            switch titleType {
            case .Full(let title):
                return title
            case .Similier(let title):
                return title
            }
        case .Keywords(_):
            return "Keywords"
        case .Category(let category):
            return category.title.capitalized
        case .Condition(let condition):
            return condition.description
        case .Person(let uid):
            return "Seller \(uid)"
        case .Item_Similier(_):
            return "Similier Items"
        case .Address(let type):
            return type.description
        }
    }
    
    var title: String {
        switch self {
        case .Title(let titleType):
            switch titleType {
            case .Full(let title):
                return title
            case .Similier(let title):
                return title
            }
        case .Keywords(_):
            return "Keywords"
        case .Category(let category):
            return category.title.capitalized
        case .Condition(let condition):
            return condition.description
        case .Person(_):
            return "Person's Item"
        case .Item_Similier(_):
            return "Similier Items"
        case .Address(let type):
            return type.description
        }
    }
}


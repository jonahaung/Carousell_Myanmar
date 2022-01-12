//
//  Bike.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import FirebaseStorage
import UIKit
import SwiftUI

struct Item: Identifiable, Codable {
    
    @DocumentID var id: String?
    
    var title: String
    var category: Category
    var description: String
    var price: Double
    var condition: Condition
    var keywords: [String]
    var seller: Person.BriefPerson
    var dateAdded: Date
    var favourites: Favourites
    var views: Views
    var images: ItemImages
    var comments: [Comment]
    var exchangeType: ExchangeType
    var address: Address
    var status: Status
    
    init(_id: String, _title: String, _category: Category, _description: String, _price: Double, _exchangeType: ExchangeType, _condition: Condition, _person: Person, _imageURLs: [String], _address: Address) {
        
        var _keywords = ([_category.title, _person.userName, _person.name, _price.description, _condition.description, _address.township, _address.state] + _title.keywords).unique.compactMap{$0?.lowercased()}
        if let x = _category.parentNode {
            _keywords.append(x.title)
        }
        id = _id
        title = _title.lowercased()
        category = _category
        description = _description
        price = _price
        condition = _condition
        seller = _person.briefPerson()
        keywords = _keywords
        dateAdded = Date()
        favourites = Favourites(count: 0, uids: [])
        views = Views(count: 0, uids: [])
        images = ItemImages(urls: _imageURLs)
        comments = []
        exchangeType = _exchangeType
        address = _address
        status = .Available
    }
}


extension Item {
    
    struct Views: Codable {
        let count: Int
        let uids: [String]
        var hasViewed: Bool {
            guard let uid = Auth.auth().currentUser?.uid else {
                return false
            }
            return uids.contains(uid)
        }
    }
    
    struct Favourites: Codable {
        let count: Int
        let uids: [String]
        var isFavourite: Bool {
            guard let uid = Auth.auth().currentUser?.uid else {
                return false
            }
            return uids.contains(uid)
        }
    }
    
    struct ItemImages: Codable, Equatable {
        let urls: [String]
        var firstImage: String { return urls.first ?? "https://www.hackingwithswift.com/img/offers/blackfriday21.png" }
        var imageDatas: [ImageData] { return urls.map{ ImageData(file_path: $0)} }
    }
    
    struct Comment: Codable, Identifiable {
        var id: String { UUID().uuidString }
        let text: String
        let date: Date
        let person: Person.BriefPerson
        
        init(_ text: String, _ person: Person) {
            self.text = text
            self.date = Date()
            self.person = person.briefPerson()
        }
    }
    
    struct Address: Codable, Equatable {
        let state: String
        let township: String
        
        var isEmpty: Bool { self == Address.none }
        static let none = Address(state: "none", township: "")
    }
    
    enum Condition: Int, Codable, UIElementRepresentable, CaseIterable {
        case BrandNew, LikeNew, WellUsed, HeavilyUsed, None
        
        var isSelected: Bool { self != .None }
        var isEmpty: Bool { !isSelected }
        var description: String { uiElements().title }
        
        func uiElements() -> Item.UIElements {
            switch self {
            case .BrandNew:
                return .init(title: "Brand New", color: .mint, iconName: "battery.100")
            case .LikeNew:
                return .init(title: "Like New", color: .green, iconName: "battery.75")
            case .WellUsed:
                return .init(title: "Well Used", color: .orange, iconName: "battery.50")
            case .HeavilyUsed:
                return .init(title: "Heavily Used", color: .red, iconName: "battery.25")
            case .None:
                return .init(title: "none", color: .accentColor, iconName: "circle.fill")
            }
        }
    }
    
    enum ExchangeType: String, Codable, CaseIterable {
        case Sell, Buy, Exchange
    }
    
    enum Status: String, Codable, CaseIterable {
        case Available, Reserved, Sold
    }
}

extension Item {
    struct UIElements {
        let title: String
        let color: Color
        let iconName: String
        static let mock = UIElements(title: Lorem.title, color: .randomColor, iconName: "circle.fill")
    }
}

extension Item {
    static var empty: Item {
        Item(_id: UUID().uuidString, _title: String(), _category: .none, _description: String(), _price: 0.0, _exchangeType: .Sell, _condition: .None, _person: .mock, _imageURLs: [], _address: .none)
    }
}

private let currencyFormatter: NumberFormatter = {
    $0.locale = .current
    $0.numberStyle = .currency
    return $0
}(NumberFormatter())

extension Double {
    func toCurrencyFormat() -> String {
        if self == 0 {
            return String()
        }
        return currencyFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

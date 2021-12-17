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
    let description: String
    let price: Int
    let condition: Condition
    var keywords: [String]
    let seller: BriefPerson
    let dateAdded: Date
    var favourites: Favourites
    var views: Views
    var images: ItemImages
    var hasSold: Bool
    var comments: [Comment]
    var dealType: DealType
    var address: Address
    
    init(_id: String, _title: String, _category: Category, _description: String, _price: Int, _dealType: DealType, _condition: Condition, _person: Person, _imageURLs: [String], _address: Address) {
        
        let _keywords = ([_category.title, _category.parentNode?.title, _person.userName, _person.name, _price.description, _condition.description, _address.township, _address.state] + _title.keywords).unique.compactMap{$0?.lowercased()}
        
        id = _id
        title = _title.lowercased()
        category = _category
        description = _description
        price = _price
        condition = _condition
        seller = BriefPerson(_person)
        keywords = _keywords
        dateAdded = Date()
        favourites = Favourites(count: 0, uids: [])
        views = Views(count: 0, uids: [])
        images = ItemImages(urls: _imageURLs)
        hasSold = false
        comments = []
        dealType = _dealType
        address = _address
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
        var id: Date { return date }
        let text: String
        let date: Date
        let person: BriefPerson
        
        init(_ text: String, _ person: Person) {
            self.text = text
            self.date = Date()
            self.person = BriefPerson(person)
        }
    }
    
    struct BriefPerson: Codable {
        let id: String?
        let userName: String
        let photoUrl: String
        var userRef: DocumentReference
        
        init(_ person: Person){
            self.id = person.id
            self.userName = person.userName
            self.photoUrl = person.photoUrl ?? ""
            self.userRef = person.documentReference
        }
    }
    
    struct Address: Codable, Equatable {
        let state: String
        let township: String
        
        var isEmpty: Bool { township == "Select Address"}
        static let none = Address(state: "", township: "Select Address")
    }
    
    enum Condition: Int, Codable, CaseIterable, Identifiable {
        var id: Condition { return self }
        
        case brandNew, likeNew, wellUsed, heavilyUsed, none
        
        var description: String {
            switch self {
            case .brandNew:
                return "Brand New"
            case .likeNew:
                return "Like New"
            case .wellUsed:
                return "Well Used"
            case .heavilyUsed:
                return "Heavily Used"
            case .none:
                return "Select Condition"
            }
        }
        var systemImageName: String {
            switch self {
            case .brandNew: return "n.circle.fill"
            case .likeNew: return "l.circle.fill"
            case .wellUsed: return "w.circle.fill"
            case .heavilyUsed: return "h.circle.fill"
            case .none: return ""
            }
        }
        var score: Int {
            switch self {
            case .brandNew:
                return 100
            case .likeNew:
                return 85
            case .wellUsed:
                return 50
            case .heavilyUsed:
                return 25
            case .none:
                return 0
            }
        }
        var color: Color {
            switch self {
            case .brandNew: return .green
            case .likeNew: return .yellow
            case .wellUsed: return .orange
            case .heavilyUsed: return .red
            case .none: return .white
            }
        }
        var isSelected: Bool { return self != .none }
    }
    
    enum DealType: Codable, CaseIterable, Identifiable {
        var id: DealType { return self }
        case Sell, Buy, Exchange
        
        var description: String {
            return "\(self)"
        }
    }
    
}

extension Item {
    
    var date_added: String {
        return dateAdded.relativeString
    }
    
    static func mock() -> Item {
        let urls = [
            "https://www.rodalink.com/pub/media/wysiwyg/blog/blog_2021/a_perfect_christmas_gift_cover_1.jpg",
            "https://www.rodalink.com/pub/media/wysiwyg/promotion_SG_2021/11-12/category_banner_sgcategory_5_1.jpg",
            "https://www.rodalink.com/pub/media/wysiwyg/promotion_SG_2021/11-12/category_banner_sgcategory_3_1.jpg",
            "https://my-live-05.slatic.net/p/2abc64078fa32fb17d8fe93c897ab06b.jpg_200x200q90.jpg_.webp",
            "https://my-live-05.slatic.net/p/3e167fecee78cf2d6db006f138cf5c01.jpg_200x200q90.jpg_.webp",
            "https://sg-live-05.slatic.net/p/a6d28f7630f5e2b013501c19686d41d8.jpg_200x200q90.jpg_.webp",
            "https://my-live-05.slatic.net/p/018f172ef8ee8030f1d878bd26ad7344.jpg_200x200q90.jpg_.webp",
        ]
//        urls.shuffle()
        let cat = Category.categories.randomElement()!
        return Item(_id: UUID().uuidString, _title: Lorem.words(3), _category: cat, _description: Lorem.sentence, _price: 2200, _dealType: .Sell, _condition: .wellUsed, _person: Person.mock, _imageURLs: urls, _address: Address.none)
    }
}

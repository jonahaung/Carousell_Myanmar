//
//  User.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/11/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Person: Identifiable, Codable {

    @DocumentID var id: String?
    
    var name: String?
    var email: String
    var phone: String?
    var photoUrl: String?
    var address: Item.Address
    var userMetadata: UserMetadata
    var ratings: Ratings
    var lastSeenDate: Date? = nil
    var viewedHistory: ViewedHistory
    
    init(id: String, name: String?, email: String?, phone: String? = nil, photoUrl: String? = nil, address: Item.Address? = nil, userMetadata: UserMetadata? = nil, ratings: Ratings? = nil) {
        self.id = id
        self.name = name
        self.email = email ?? ""
        self.phone = phone
        self.photoUrl = photoUrl ?? "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg"
        self.address = address ?? .none
        self.userMetadata = userMetadata ?? UserMetadata.mock
        self.ratings = ratings ?? .init(values: [])
        self.viewedHistory = .init(categories: [], searchedWords: [])
    }
    
    init(_ user: User, name: String, photoUrl: String?) {
        self.init(id: user.uid, name: name, email: user.email, phone: user.phoneNumber, photoUrl: photoUrl, address: Optional.none, userMetadata: .init(user), ratings: .init(values: []))
    }
}

// Ratings
extension Person {
    
    struct ViewedHistory: Codable, Equatable {
        var categories: [Category]
        var searchedWords: [String]
        
        enum ViewedHistoryType: CaseIterable, Hashable {
            
            case category(Category)
            case searchWords(String)
            
            static let allCases: [Person.ViewedHistory.ViewedHistoryType] = [.category(.none), .searchWords("")]
            
            var title: String {
                switch self {
                case .category(_):
                    return "Category"
                case .searchWords(_):
                    return "Search History"
                }
            }
        }
    }
    
    func briefPerson() -> BriefPerson {
        BriefPerson.init(id: self.id ?? "", userName: userName, userRef: documentReference)
    }
    
    struct BriefPerson: Codable {
        let id: String
        let userName: String
        let userRef: DocumentReference
    
        func getPerson() async throws -> Person? {
            do {
                let ref = try await userRef.getDocument()
                return try ref.data(as: Person.self)
            }catch {
                throw(error)
            }
        }
        
        var isOwner: Bool {
            guard let userId = AuthenticationService.shared.currentUserViewModel?.id else {
                return false
            }
            return id == userId
        }
    }
    
    struct Ratings: Codable, Equatable {
        
        struct Rating: Codable, Equatable {
            let person:BriefPerson
            let value: Int
            static func == (lhs: Person.Ratings.Rating, rhs: Person.Ratings.Rating) -> Bool {
                lhs.person.id == rhs.person.id && lhs.value == rhs.value
            }
        }
    
        var values: [Rating]
        var count: Int { values.count }
        
        var overallRating: Int {
            guard !values.isEmpty else { return 0 }
            let defaultStarValue = 5
            let totalUserRated = count
            let sumMax = totalUserRated * defaultStarValue
            let actualSum = values.map{ $0.value }.reduce(0, +)
            return (actualSum * defaultStarValue) / sumMax
        }
    
        var hasRated: Bool {
            return values.filter{$0.person.id == Auth.auth().currentUser?.uid ?? "" }.count > 0
        }
        
        var color: UIColor {
            let x = overallRating
            switch x {
            case 1:
                return .systemRed
            case 2:
                return .systemOrange
            case 3:
                return .systemYellow
            case 4:
                return .systemGreen
            case 5:
                return .systemMint
            default:
                return .clear
            }
        }
        
        static func == (lhs: Person.Ratings, rhs: Person.Ratings) -> Bool {
            lhs.values == rhs.values
        }
    }
}

// UserMetadata
extension Person {

    struct UserMetadata: Codable {
        
        let creationDate: Date
        let lastSignInDate: Date
        var isEmailVerified: Bool
        let providerData: [ProviderData]
        
        init(creationDate: Date, lastSignInDate: Date, isEmailVerified: Bool, providerData: [ProviderData]) {
            self.creationDate = creationDate
            self.lastSignInDate = lastSignInDate
            self.isEmailVerified = isEmailVerified
            self.providerData = providerData
        }
        init(_ user: User) {
            creationDate = user.metadata.creationDate ?? Date()
            lastSignInDate = user.metadata.lastSignInDate ?? Date()
            isEmailVerified = user.isEmailVerified
            providerData = user.providerData.map(ProviderData.init)
        }
        
        struct ProviderData: Codable {
            let uid: String
            let providerID: String
            let displayName: String?
            let email: String?
            let phoneNumber: String?
            let photoUrl: String?
            
            init(_ userInfo: UserInfo) {
                uid = userInfo.uid
                providerID = userInfo.providerID
                displayName = userInfo.displayName
                email = userInfo.email
                phoneNumber = userInfo.phoneNumber
                photoUrl = userInfo.photoURL?.absoluteString
            }
        }
        static let mock: UserMetadata = .init(creationDate: Date(), lastSignInDate: Date(), isEmailVerified: true, providerData: [])
    }
}

extension Person {
    var userName: String {
        return (email.components(separatedBy: "@").first ?? "")
    }
    var documentReference: DocumentReference {
        return Firestore.firestore().collection("users").document(id ?? "")
    }
    static let mock = Person.init(id: "3YUrw3R0cua4fWvcuro26zbei6O3", name: "John Doe", email: "johndoe@gmail.com", phone: "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg")

}

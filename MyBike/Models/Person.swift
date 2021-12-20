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
    
    init(id: String, name: String?, email: String?, phone: String? = nil, photoUrl: String? = nil, address: Item.Address? = nil, userMetadata: UserMetadata? = nil, ratings: Ratings? = nil) {
        self.id = id
        self.name = name
        self.email = email ?? ""
        self.phone = phone
        self.photoUrl = photoUrl ?? "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg"
        self.address = address ?? .none
        self.userMetadata = userMetadata ?? UserMetadata(Auth.auth().currentUser!)
        self.ratings = ratings ?? .init(values: [])
    }
    
    init(_ user: User, name: String, photoUrl: String?) {
        self.init(id: user.uid, name: name, email: user.email, phone: user.phoneNumber, photoUrl: photoUrl, address: Optional.none, userMetadata: .init(user), ratings: .init(values: []))
    }
}

// Ratings
extension Person {
    
    struct Ratings: Codable, Equatable {
    
        var values: [Rating]
        struct Rating: Codable, Equatable {
            let person: Item.BriefPerson
            let value: Int
            static func == (lhs: Person.Ratings.Rating, rhs: Person.Ratings.Rating) -> Bool {
                return lhs.person == rhs.person && lhs.value == rhs.value
            }
        }
        
        var count: Int { values.count }
        
        var overallRating: Int {
            guard !values.isEmpty else { return 0 }
            let totalUserRated = values.count
            let sumMax = totalUserRated * 5
            let actualSum = values.map{ $0.value }.reduce(0, +)
            return (actualSum * 5) / sumMax
        }
        
        static func == (lhs: Person.Ratings, rhs: Person.Ratings) -> Bool {
            return lhs.values == rhs.values
        }
        
        var hasRated: Bool {
            return values.filter{$0.person.id == Auth.auth().currentUser?.uid ?? "" }.count > 0
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
    }
}

extension Person {
    var userName: String {
        return "@" + (email.components(separatedBy: "@").first ?? "")
    }
    var documentReference: DocumentReference {
        return Firestore.firestore().collection("users").document(id ?? "")
    }
    static let mock = Person.init(id: "3YUrw3R0cua4fWvcuro26zbei6O3", name: "John Doe", email: "johndoe@gmail.com", phone: "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg")

}

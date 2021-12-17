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
    var phone: String? = nil
    var photoUrl: String?
    var hasEmailVerified: Bool? = false
    var address: Item.Address? = Item.Address.none
    
    var userName: String {
        return "@" + (email.components(separatedBy: "@").first ?? "")
    }
}


extension Person {
    
    var documentReference: DocumentReference {
        return Firestore.firestore().collection("users").document(id ?? "")
    }
    static let mock = Person.init(id: "3YUrw3R0cua4fWvcuro26zbei6O3", name: "John Doe", email: "johndoe@gmail.com", photoUrl: "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg")

}

//
//  PersonViewModel.swift
//  MyBike
//
//  Created by Aung Ko Min on 21/12/21.
//

import Combine
import Firebase

class PersonViewModel: ObservableObject, Identifiable {
    
    var id = ""
    let userName: String
    @Published var name: String
    @Published var email: String
    @Published var phone: String
    @Published var photoUrl: String
    @Published var hasEmailVerified: Bool
    @Published var address = Item.Address.none
    @Published var ratings: Person.Ratings
    
    var person: Person
    internal let personRepo = PersonRepository()
    
    init(person: Person) {
        id = person.id ?? ""
        userName = person.userName
        name = person.name ?? ""
        email = person.email
        phone = person.phone ?? ""
        photoUrl = person.photoUrl ?? ""
        hasEmailVerified = person.userMetadata.isEmailVerified
        address = person.address
        ratings = person.ratings
        self.person = person
    }
}

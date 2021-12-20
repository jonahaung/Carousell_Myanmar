//
//  PeopleViewModel.swift
//  MyBike
//
//  Created by Aung Ko Min on 11/11/21.
//

import Combine
import Firebase

class PersonViewModel: ObservableObject, Identifiable {
    
    var id = ""
    @Published var userName: String
    @Published var name: String
    var email: String
    var phone: String
    @Published var photoUrl: String
    @Published var hasEmailVerified: Bool
    @Published var address = Item.Address.none
    @Published var ratings: Person.Ratings
    
    var person: Person
    private let personRepo = PersonRepository()
    
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
    
    var hasChanges: Bool {
        return person.name != name || person.photoUrl != photoUrl || person.userMetadata.isEmailVerified != hasEmailVerified || person.address != address || ratings != person.ratings || phone != person.phone
    }
    
    func update() {
        guard hasChanges else { return }
        var new = person
        new.name = name
        new.email = email
        new.photoUrl = photoUrl
        new.userMetadata.isEmailVerified = hasEmailVerified
        new.address = address
        new.ratings = ratings
        new.phone = phone
        personRepo.update(new)
        self.person = new
    }
}

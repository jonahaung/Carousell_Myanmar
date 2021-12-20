//
//  PersonRepository.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class PersonRepository {
    
    private let path: String = "users"
    private let store = Firestore.firestore()
    
    
    func add(_ person: Person) {
        do {
            _ = try store.collection(path).document(person.id!).setData(from: person)
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription).")
        }
    }
    
    func update(_ person: Person, _ completion: ((Error?) -> Void)? = nil) {
        guard let personId = person.id else { return }
        do {
            try store.collection(path).document(personId).setData(from: person, merge: true, completion: completion)
        } catch {
            completion?(error)
        }
    }
    
    func find(_ personId: String, completion: @escaping (Person?, Error?) -> Void ) {
        store.collection(path).document(personId).getDocument { (snap, error) in
            let person = try? snap?.data(as: Person.self)
            DispatchQueue.main.async {
                completion(person, error)
            }
        }
    }
    
    func remove(_ person: Person) {
        guard let personId = person.id else { return }
        store.collection(path).document(personId).delete { error in
            if let error = error {
                print("Unable to remove card: \(error.localizedDescription)")
            }
        }
    }
}

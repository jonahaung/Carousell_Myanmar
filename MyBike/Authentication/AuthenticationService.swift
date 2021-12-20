//
//  AuthenticationService.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import FirebaseFirestore
import FirebaseAuth
import Combine

class AuthenticationService: ObservableObject {
    
    static let shared = AuthenticationService()
    
    @Published var personViewModel: PersonViewModel?

    var isLoggedIn: Bool { personViewModel != nil }
    
    private var authenticationStateHandler: AuthStateDidChangeListenerHandle?
    private var personListener: ListenerRegistration?
    private let personRepo = PersonRepository()
        
    init() {
        addListeners()
    }
    
    private func addListeners() {
        if let handle = authenticationStateHandler {
            Auth.auth().removeStateDidChangeListener(handle)
        }
        authenticationStateHandler = Auth.auth()
            .addStateDidChangeListener { auth, user in
                if let user = user {
                    self.addPersonListener(user: user)
                } else {
                    self.personListener?.remove()
                    self.personViewModel = nil
                }
            }
    }
    
    private func addPersonListener(user: User) {
        personListener?.remove()
        personListener = Firestore.firestore().collection("users").document(user.uid)
            .addSnapshotListener(includeMetadataChanges: true) { (snap, err) in
                do {
                    if let person = try snap?.data(as: Person.self) {
                        
                        DispatchQueue.main.async {
                            self.personViewModel = PersonViewModel(person: person)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.personViewModel = nil
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
            }
    }
    
    
    static func signIn(email: String, password: String, completion: @escaping (User?, Error?) -> Void ) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            completion(result?.user, error)
        }
    }
    
    static func createUser(email: String, password: String, completion: @escaping (User?, Error?) -> Void ) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            completion(result?.user, error)
        }
    }
    
    static func sendPasswordReset(email: String, completion: @escaping (Error?) -> Void ) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
    
    static func signOut() {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

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
    
    @Published var currentUserViewModel: CurrentUserViewModel?
    @Published var alert = AlertObject("", buttonText: "", show: false)
    var isLoggedIn: Bool { currentUserViewModel != nil }
    
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
                    self.currentUserViewModel = nil
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
                            self.currentUserViewModel = CurrentUserViewModel(person: person)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.currentUserViewModel = nil
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
            }
    }
    
    func signOut() {
        alert = .init("Are you sure to log out?", buttonText: "Continue Log Out", action: {
            AuthenticationService.signOut()
        }, cancelAction: {})
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

//
//  SignInWithEmailManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import Foundation
import SwiftUI

final class SignInWithEmailManager: ObservableObject {
    
    enum AuthFlow: CaseIterable {
        case SignIn, Register, ForgetPassword
        var title: String {
            switch self {
            case .SignIn:
                return "Sign In"
            case .Register:
                return "Register"
            case .ForgetPassword:
                return "Forget Password"
            }
        }
    }
    
    @Published var authFlow = AuthFlow.SignIn
    
    @Published var email = ""
    @Published var password = ""
    @Published var secondPassword = ""
    @Published var displayName = ""
    
    @Published var alert = AlertObject("", buttonText: "", show: false)
    
    private let personRepo = PersonRepository()
    
    var presentationMode: Binding<PresentationMode>
    
    init(_ _presentationMode: Binding<PresentationMode>) {
        presentationMode = _presentationMode
    }
    
    var isValid: Bool {
        let email = email.trimmed
        var isValid = false
        switch authFlow {
        case .SignIn:
            if email.isValidEmail() && password.count >= 6 {
                isValid = true
            }
        case .Register:
            if email.isValidEmail() && password.count >= 6 && password == secondPassword {
                isValid = true
            }
        case .ForgetPassword:
            if email.isValidEmail() {
                isValid = true
            }
        }
        return isValid
    }
    
    func handleContinue() {
        switch authFlow {
        case .SignIn:
            signIn()
        case .Register:
            register()
        case .ForgetPassword:
            forgetPassword()
        }
    }
    
    
    private func signIn() {
        let email = email.trimmed
        guard !email.isEmpty && !password.isEmpty else {
            self.alert = AlertObject("Please enter Email and Password")
            return
        }
        AuthenticationService.signIn(email: email, password: password) { (user, error) in
            if let error = error {
                self.alert = AlertObject(error.localizedDescription)
            } else {
                if let user = user {
                    self.personRepo.find(user.uid) { (person, error) in
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    private func register(){
        let email = email.trimmed
        AuthenticationService.createUser(email: email, password: password) { (user, error) in
            if let error = error {
                self.alert = AlertObject(error.localizedDescription)
            } else {
                if let user = user {
                    let person = Person(id: user.uid, name: self.displayName, email: user.email!)
                    self.personRepo.add(person)
                }
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private func forgetPassword() {
        let email = email.trimmed
        AuthenticationService.sendPasswordReset(email: email) { error in
            if let error = error {
                self.alert = AlertObject(error.localizedDescription)
            }
        }
    }
    
    func reset() {
        email = String()
        password = String()
        displayName = String()
        secondPassword = String()
    }
    
    var hasData: Bool {
        return email.isEmpty || password.isEmpty || displayName.isEmpty || secondPassword.isEmpty
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
extension String: Identifiable {
    public var id: String {
        return self
    }
}

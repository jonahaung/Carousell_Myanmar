//
//  SignInView.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/11/21.
//

import SwiftUI

struct AuthView: View {
    
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
    
    @State private var authFlow = AuthFlow.SignIn
    
    @Environment(\.presentationMode) var presentationMode
    private let personRepo = PersonRepository()
    
    @State private var email = ""
    @State private var password = ""
    @State private var secondPassword = ""
    @State private var displayName = ""
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                contentView
                Button("Continue", action: handleContinue)
                    .disabled(!isValid)
                    .padding()
                Spacer()
                bottomBar
            }
            .padding()
            .navigationTitle(authFlow.title)
            .alert(item: $errorMessage) {
                Alert(title: Text("Error"), message: Text($0), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    
    
    private var contentView: some View {
        VStack(spacing: 10) {
            switch authFlow {
            case .SignIn:
                TextField("Email", text: $email, prompt: Text("Email Address"))
                    .textContentType(.emailAddress)
                Divider()
                SecureField("Password", text: $password)
                    .textContentType(.password)
            case .Register:
                TextField("Display Name", text: $displayName, prompt: Text("Display Name"))
                    .textContentType(.name)
                Divider()
                TextField("Email", text: $email, prompt: Text("Email Address"))
                    .textContentType(.emailAddress)
                Divider()
                SecureField("Password", text: $password)
                    .textContentType(.password)
                Divider()
                SecureField("Retype Password", text: $secondPassword)
                    .textContentType(.newPassword)
            case .ForgetPassword:
                TextField("Email", text: $email, prompt: Text("Email Address"))
                    .textContentType(.emailAddress)
            }
            
            Divider()
        }
        .autocapitalization(.none)
        .frame(width: 250)
    }
    
    private var bottomBar: some View {
        HStack {
            if authFlow == .SignIn {
                Button("Register") {
                    authFlow = .Register
                }
            } else {
                Button("Sign In") {
                    authFlow = .SignIn
                }
            }
            Spacer()
            Button("Reset Password") {
                authFlow = .ForgetPassword
            }
        }
    }
    
    private var isValid: Bool {
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
    
    private func handleContinue() {
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
        guard !email.isEmpty && !password.isEmpty else {
            return
        }
        AuthenticationService.signIn(email: email, password: password) { (user, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                if let user = user {
                    personRepo.find(user.uid) { (person, error) in
    
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
            }
        }
    }
    
    private func register(){
        AuthenticationService.createUser(email: email, password: password) { (user, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                if let user = user {
                    let person = Person(id: user.uid, name: displayName, email: user.email!)
                    personRepo.add(person)
                }
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private func forgetPassword() {
        AuthenticationService.sendPasswordReset(email: email) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            }
        }
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

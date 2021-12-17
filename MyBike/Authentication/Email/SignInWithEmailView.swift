//
//  SignInWithEmailView.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI

struct SignInWithEmailView: View {
    
    enum FocusedField {
        case email, password, displayName, retypePassword
    }
    
    @FocusState private var focusedField: FocusedField?
    
    @StateObject private var manager: SignInWithEmailManager
    
    init(_ _presentationMode: Binding<PresentationMode>) {
        _manager = StateObject(wrappedValue: SignInWithEmailManager(_presentationMode))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                Section(header: headerLabel, footer: submitButton) {
                    switch manager.authFlow {
                    case .SignIn:
                        emailTextField
                        passwordTextField
                    case .Register:
                        emailTextField
                        displayNameTextField
                        passwordTextField
                        retypePasswordTextField
                    case .ForgetPassword:
                        emailTextField
                    }
                }
            }
            .submitLabel(.next)
            .onSubmit(onSubmit)
            bottomBar
        }
        .navigationBarItems(trailing: navTrailingView)
        .confirmationAlert($manager.alert)
    }
    
    private func onSubmit() {
        switch manager.authFlow {
        case .SignIn:
            if focusedField == .email {
                manager.email = manager.email.trimmed
                if !manager.email.isEmpty {
                    focusedField = .password
                }else {
                    focusedField = .email
                }
            } else {
                focusedField = nil
                manager.handleContinue()
            }
        case .Register:
            if let focusedField = focusedField {
                switch focusedField {
                case .email:
                    self.focusedField = .displayName
                case .displayName:
                    self.focusedField = .password
                case .password:
                    self.focusedField = .retypePassword
                case .retypePassword:
                    self.focusedField = nil
                    manager.handleContinue()
                }
            }
        case .ForgetPassword:
            manager.handleContinue()
        }
    }
    
    private var headerLabel: some View {
        Text(manager.authFlow.title)
    }
    
    private var submitButton: some View {
        Button(action: onSubmit) {
            Text("Continue")
                .formSubmitButtonStyle(.accentColor)
        }.disabled(!manager.isValid)
    }
    
    private var emailTextField: some View {
        TextField("Email", text: $manager.email, prompt: Text("Email Address"))
            .textContentType(.emailAddress)
            .focused($focusedField, equals: .email)
            .autocapitalization(.none)
        
    }
    
    private var passwordTextField: some View {
        SecureField("Password", text: $manager.password)
            .textContentType(.password)
            .focused($focusedField, equals: .password)
            
    }
    
    
    private var displayNameTextField: some View {
        TextField("Display Name", text: $manager.displayName, prompt: Text("Display Name"))
            .textContentType(.name)
            .focused($focusedField, equals: .displayName)
            .autocapitalization(.words)
    }
    
    private var retypePasswordTextField: some View {
        SecureField("Retype Password", text: $manager.secondPassword)
            .textContentType(.newPassword)
            .focused($focusedField, equals: .retypePassword)
    }
    
    
    
    private var bottomBar: some View {
        HStack {
            Button(manager.authFlow == .SignIn ? "Register" : "Sign In") {
                manager.authFlow = manager.authFlow == .SignIn ? .Register : .SignIn
                focusedField = .email
            }
            Spacer()
            Button("Reset Password") {
                manager.authFlow = .ForgetPassword
                focusedField = .email
            }
        }
        .padding()
    }
    
    private var navTrailingView: some View {
        HStack {
            Button("Clear", action: {
                manager.reset()
                focusedField = .email
            })
                .disabled(!manager.hasData)
        }
    }
}



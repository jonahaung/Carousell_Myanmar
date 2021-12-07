//
//  UserProfileView.swift
//  MyBike
//
//  Created by Aung Ko Min on 12/9/21.
//

import SwiftUI

struct UserProfileView: View {
    
    @EnvironmentObject var authenticationService: AuthenticationService
    @State private var showSignIn = false

    var person: Person? { authenticationService.person }
    
    var body: some View {
        NavigationView {
            List {
                Section{
                    if let url = person?.photoUrl {
                        PersonImageView(url, .big)
                            .listRowInsets(EdgeInsets())
                    }
                }
                Section{
                    Text("User Name").badge(person?.userName ?? "")
                    Text("Email").badge(person?.email ?? "")
                }
                
                Section{
                    Button {
                        if authenticationService.isLoggedIn {
                            AuthenticationService.signOut()
                        } else {
                            showSignIn = true
                        }
                    } label: {
                        Text(authenticationService.isLoggedIn ? "Log Out" : "Sign In")
                            .formSubmitButtonStyle(authenticationService.isLoggedIn ? .pink : .accentColor)
                    }
                }
            }
            
            .navigationTitle("User Profile")
            .sheet(isPresented: $showSignIn) {
                AuthView()
            }
        }
    }
}

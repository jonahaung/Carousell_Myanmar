//
//  UserProfileView.swift
//  MyBike
//
//  Created by Aung Ko Min on 12/9/21.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    @EnvironmentObject var authenticationService: AuthenticationService
    
    var body: some View {
        Group {
            if let currentUserViewModel = authenticationService.currentUserViewModel {
                CurrentUserProfile_LoggedIn()
                    .environmentObject(currentUserViewModel)
            } else {
                CurrentUserProfile_NotLoggedIn()
            }
        }
        .navigationTitle("User Profile")
    }
}

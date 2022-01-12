//
//  UserProfileNotLoggedInView.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI

struct CurrentUserProfile_NotLoggedIn: View {
    
    @EnvironmentObject var authenticationService: AuthenticationService
    
    var body: some View {
        VStack {
            Text("You are not logged in")
            Text("Sign In")
                .formSubmitButtonStyle(authenticationService.isLoggedIn ? .pink : .accentColor)
                .tapToPresent(SignInView(), true)
        }

    }
}

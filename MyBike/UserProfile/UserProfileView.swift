//
//  UserProfileView.swift
//  MyBike
//
//  Created by Aung Ko Min on 12/9/21.
//

import SwiftUI

struct UserProfileView: View {
    
    @EnvironmentObject var authenticationService: AuthenticationService
    
    var body: some View {
        NavigationView {
            Group {
                if let currentUserViewModel = authenticationService.currentUserViewModel {
                    UserProfileLoggedInView()
                        .environmentObject(currentUserViewModel)
                } else {
                    UserProfileNotLoggedInView()
                }
            }
            .navigationTitle("User Profile")
            .background(Color.groupedTableViewBackground)
            .navigationBarItems(leading: navBarLeadingView)
        }
        .navigationViewStyle(.stack)
        .confirmationAlert($authenticationService.alert)
    }
    
    private var navBarLeadingView: some View {
        HStack {
            Image(systemName: "gearshape.fill")
                .tapToPush(SettingsView().anyView)
        }
    }
}

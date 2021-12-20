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
                if let personViewModel = authenticationService.personViewModel {
                    UserProfileLoggedInView()
                        .environmentObject(personViewModel)
                } else {
                    UserProfileNotLoggedInView()
                }
            }
            .navigationTitle("User Profile")
            .background(Color.groupedTableViewBackground)
        }
        .navigationViewStyle(.stack)
    }
}

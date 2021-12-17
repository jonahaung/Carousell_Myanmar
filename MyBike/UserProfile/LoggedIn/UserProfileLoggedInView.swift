//
//  UserProfileLoggedInView.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI
import FirebaseAuth

struct UserProfileLoggedInView: View {
    
    @ObservedObject var personViewModel: PersonViewModel

    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            UserProfileAccountSection(personViewModel: personViewModel)
            UserProfileItemsSection(personViewModel: personViewModel)
            
            Section("Favourites"){
                DoubleColGrid(.favourites)
            }
            
            Section("Seen"){
                DoubleColGrid(.seenItems)
            }
            
            Section{
                Text("Sign Out")
                    .formSubmitButtonStyle(.pink)
                    .onTapGesture(perform: AuthenticationService.signOut)
            }.insetGroupSectionStyle()
        }
        .navigationTitle("User Profile")
    }
}

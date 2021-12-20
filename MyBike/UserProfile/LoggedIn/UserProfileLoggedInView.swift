//
//  UserProfileLoggedInView.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI

struct UserProfileLoggedInView: View {
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            UserProfileAccountSection()
            UserProfileItemsSection()
            
            Section("Favourites"){
                DoubleColGrid(.favourites)
            }
            
            Section("Seen"){
                DoubleColGrid(.seenItems)
            }
        }
        .navigationTitle("User Profile")
    }
}

//
//  UserProfileLoggedInView.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI

struct UserProfileLoggedInView: View {
    @EnvironmentObject private var currentUserViewModel: CurrentUserViewModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            UserProfileAccountSection()
            UserProfileMenuSection()
//            UserProfileItemsSection()
            
            DoubleColGrid(.search([.UserItem(currentUserViewModel.person)]))
        }
    }
}

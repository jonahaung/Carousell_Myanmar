//
//  UserProfileLoggedInView.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI

struct CurrentUserProfile_LoggedIn: View {
    @EnvironmentObject private var currentUserViewModel: CurrentUserViewModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            CurrentUserProfile_LoggedIn_Section_Account()
            CurrentUserProfile_LoggedIn_Section_Menu()
            CurrentUserProfile_LoggedIn_Section_Items()
            DoubleCol_Grid()
                .environmentObject(AppBackendManager.shared.itemBackendManager(for: .search([.UserItem(currentUserViewModel.person)])))
        }
    }
}

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
        
        CurrentUserProfileProfilePhoto()
        
        Divider()
        
        SectionWithTitleView("Account") {
            CurrentUserProfileAccountInfo()
        }
        
        SectionWithTitleView("Menus") {
            CurrentUserProfile_LoggedIn_Section_Menu()
        }
        
        SectionWithTitleView("My Items") {
            CurrentUserProfile_LoggedIn_Section_Items()
        }
        
        let itemMenu = ItemMenu.search([.Person(uid: currentUserViewModel.person.id!)])
        SectionWithItemTitleView.init(itemMenu, showViewAll: false) {
            ItemList(itemMenu)
        }
        
    }
}

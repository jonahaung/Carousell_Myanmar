//
//  UserProfileItemsSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI

struct CurrentUserProfile_LoggedIn_Section_Items: View {
    
    @EnvironmentObject private var personViewModel: CurrentUserViewModel
    @EnvironmentObject private var authService: AuthenticationService
    
    var body: some View {
        VStack(alignment: .leading) {
            FormListCell(iconName: "bookmark.fill") {
                Text("Cached Histories & Preferences")
                    .tapToPush(ViewedHistoryView().environmentObject(personViewModel))

            }
            
    
            FormListCell(iconName: "flag.fill") {
                Text("Purchased Items").tapToPush(Text("Purchased Items"))
            }
    
            FormListCell(iconName: "dollarsign.circle.fill") {
                Text("Sale Items").tapToPush(Text("Sale Items"))
            }
            
            if let uid = authService.currentUserViewModel?.id {
                FormListCell(iconName: "heart.fill") {
                    Text("Your Liked Items").tapToPushItemsList(.MyFavourites(uid))
                }
                
               
                FormListCell(iconName: "eye.circle.fill") {
                    Text("Your Seen Items")
                }.tapToPushItemsList(.MySeenItems(uid))
            }
        }
        .insetGroupSectionStyle()
    }
}

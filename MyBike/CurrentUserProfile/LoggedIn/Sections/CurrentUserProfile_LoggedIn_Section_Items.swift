//
//  UserProfileItemsSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI

struct CurrentUserProfile_LoggedIn_Section_Items: View {
    
    @EnvironmentObject private var personViewModel: CurrentUserViewModel
    
    var body: some View {
        Group {
            VStack(alignment: .leading) {
                Text("Purchases")
                    .tapToPush(Text("Purchases").anyView)
                Divider()
                Text("Sale")
                    .tapToPush(Text("Sales").anyView)
                Divider()
                Text("Favourites")
                    .tapToPushItemsList(.favourites)
                Divider()
                Text("Seen Items")
                    .tapToPushItemsList(.seenItems)
            }
        }
        .insetGroupSectionStyle()
    }
}

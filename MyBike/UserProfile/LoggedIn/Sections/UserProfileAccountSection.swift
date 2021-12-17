//
//  UserProfilePersonInfoSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI
import Firebase

struct UserProfileAccountSection: View {

    @ObservedObject var personViewModel: PersonViewModel
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    PersonImageView(personViewModel.photoUrl, .medium)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(personViewModel.userName)
                        Text(personViewModel.name)
                        Text(personViewModel.email)
                        Text(personViewModel.address.state)
                    }.padding()
                }
                
                HStack {
                    Text("Edit")
                        .foregroundColor(.accentColor)
                        .tapToPresent(UserProfileUpdateView(manager: UserProfileUpdateManager(personViewModel: personViewModel)).anyView, true)
                }
            }
        }
        .insetGroupSectionStyle(5)
    }
}

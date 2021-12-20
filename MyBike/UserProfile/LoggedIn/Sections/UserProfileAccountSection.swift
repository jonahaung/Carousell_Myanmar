//
//  UserProfilePersonInfoSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI
import Firebase

struct UserProfileAccountSection: View {

    @EnvironmentObject private var personViewModel: PersonViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                PersonImageView(personViewModel.photoUrl, .medium)
                let overall = personViewModel.ratings.overallRating
                PopularityBadge(score: (100*overall)/5)
            }
            
            HStack {
                RatingView().foregroundColor(.secondary)
                    .environmentObject(personViewModel)
                Text(personViewModel.ratings.count.description).italic().fontWeight(.light).padding().foregroundStyle(.secondary)
                Spacer()
                Text("Update")
                    .foregroundColor(.accentColor)
                    .tapToPresent(UserProfileUpdateView(manager: UserProfileUpdateManager(personViewModel: personViewModel)).anyView, true)
            }

            Divider()
            VStack(spacing: 8) {
                Group {
                    FormCell(text: "Name", rightView: Text(personViewModel.name).bold().anyView)
                    FormCell(text: "User Name", rightView: Text(personViewModel.userName).italic().anyView)
                    FormCell(text: "Email", rightView: Text(personViewModel.email).italic().underline().anyView)
                    FormCell(text: "Phone", rightView: Text(personViewModel.phone).anyView)
                }
                Divider()
                Group{
                    FormCell(text: "User Since", rightView: Text(personViewModel.person.userMetadata.creationDate.relativeString).anyView)
                    FormCell(text: "Last login", rightView: Text(personViewModel.person.userMetadata.lastSignInDate.relativeString).anyView)
                }
                Divider()
                FormCell(text: "Email Verified", rightView: Text("\(personViewModel.hasEmailVerified.description)").anyView)
                Divider()
                FormCell(text: personViewModel.address.state, rightView: Text(personViewModel.address.township).anyView)
            }
            Divider()
            Button("Sign Out"){
                AuthenticationService.signOut()
            }
            .accentColor(.red)
//            Text("Sign Out")
//                .formSubmitButtonStyle(.pink)
//                .onTapGesture(perform: AuthenticationService.signOut)
        }
        .insetGroupSectionStyle()
    }
}

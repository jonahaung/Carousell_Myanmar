//
//  UserProfilePersonInfoSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI
import Firebase

struct UserProfileAccountSection: View {
    
    @EnvironmentObject private var currentUserViewModel: CurrentUserViewModel
    
    var body: some View {
        
        profilePhotoSection
        
        ratingSection
        
        infoSection
    }
    
    
    private var profilePhotoSection: some View {
        HStack {
            let imageData = ImageData(file_path: currentUserViewModel.photoUrl)
            PersonImageView(currentUserViewModel.photoUrl, .big).shadow(radius: 6)
                .tapToPresent(FullScreenImagesCarouselView(imageDatas: [imageData], selectedData: .constant(imageData)).anyView, true)
            Spacer()
            HStack {
                Image(systemName: "square.and.arrow.up")
                Image(systemName: "qrcode")
            }
            .imageScale(.large)
        }
        .padding()
    }
    
    private var ratingSection: some View {
        HStack(spacing: 15) {
            RatingView()
            Text("\(currentUserViewModel.ratings.count) ratings")
                .tapToPush(Text("Ratings View").anyView)
            Spacer()
            let overall = currentUserViewModel.ratings.overallRating
            PopularityBadge(score: (100*overall)/5)
        }
        .padding(.horizontal)
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(currentUserViewModel.name).font(.FjallaOne())
                Image(systemName: currentUserViewModel.hasEmailVerified ? "checkmark.seal.fill" : "exclamationmark.circle.fill")
                    .foregroundColor(currentUserViewModel.hasEmailVerified ? .indigo : .pink)
                    .imageScale(.small)
            }
            
            Group {
                Label(currentUserViewModel.userName, systemImage: "person.crop.circle.fill")
                Label(currentUserViewModel.email, systemImage: "at.circle.fill")
                Label(currentUserViewModel.phone, systemImage: "phone.circle.fill")
                Label.init("\(currentUserViewModel.address.township) \(currentUserViewModel.address.state)", systemImage: "map.circle.fill")
            }.foregroundStyle(.secondary)
            
            Divider()
            Group {
                FormCell(text: "Member Since", rightView: Text(currentUserViewModel.person.userMetadata.creationDate.relativeString).anyView)
                FormCell(text: "Last Login", rightView: Text(currentUserViewModel.person.userMetadata.lastSignInDate.relativeString).anyView)
            }
            Divider()
            HStack {
                Button("Sign Out"){
                    AuthenticationService.shared.signOut()
                }
                .accentColor(.pink)
                Spacer()
                Text("Account Settings")
                    .tapToPush(UserProfileUpdateView().environmentObject(currentUserViewModel).anyView)
            }
            
        }
        .insetGroupSectionStyle()
    }
}

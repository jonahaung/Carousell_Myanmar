//
//  UserProfileUpdateView.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI

struct CurrentUserProfile_LoggedIn_Section_Account_Update: View {

    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var currentUserViewModel: CurrentUserViewModel
    
    var body: some View {
        Form {
            Section(header: imageView, footer: Text("Tap to edit")) {
                TextField("Display Name", text: $currentUserViewModel.name)
                TextField("Phone Number", text: $currentUserViewModel.phone).textContentType(.telephoneNumber)
                SellAddressSection(address: $currentUserViewModel.address)
                    .tapToPush(RegionPicker(address: $currentUserViewModel.address).anyView)
            }
            
            Section {
                Person_Profile_Rating_Editable()
            }
            
            Section {
                if !currentUserViewModel.hasEmailVerified {
                    Button("Verify Email"){
                        
                    }
                }
                Button("Link Account"){
                    
                }
                Button("Reset Password"){
                    
                }
                Button("Deactivate Account"){
                    
                }
            }
        }
        .navigationTitle("Update Profile")
        .navigationBarItems(trailing: navTrailingView)
    }
    
    private var imageView: some View {
        HStack {
            Spacer()
            VStack {
                PersonImageView(currentUserViewModel.photoUrl, .big)
                    .tapToPresent(imagePickerEditor.anyView, true)
                    .shadow(radius: 6)
                Text("Upload")
                    .tapToPresent(imagePickerEditor.anyView, true)
            }
            Spacer()
        }.padding(.bottom)
    }
    
    private var imagePickerEditor: some View {
        ImagePickerCropperView(onPick: { image in
            currentUserViewModel.uploadImage(image: image)
        }, shape: .circle(maskOnly: false), ratio: .canUseMultiplePresetFixedRatio(defaultRatio: 1))
    }
    
    private var navTrailingView: some View {
        HStack {
            Button("Save") {
                currentUserViewModel.update()
                presentationMode.wrappedValue.dismiss()
            }.disabled(!currentUserViewModel.hasChanges)
        }
    }
}

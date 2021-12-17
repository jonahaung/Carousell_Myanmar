//
//  UserProfileUpdateView.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI

struct UserProfileUpdateView: View {

    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var manager: UserProfileUpdateManager
    
    var body: some View {
        NavigationView {
            List {
                
                Section(header: imageView) {
                    FormCell(text: "User Name", rightView: TextField("UserName", text: $manager.personViewModel.userName).anyView)
                    FormCell(text: "Name", rightView: TextField("Name", text: $manager.personViewModel.name).anyView)
                }
                
                Section {
                    FormCell(text: "Region", rightView: SellAddressSection(address: $manager.personViewModel.address).anyView)
                        .tapToPush(RegionPicker(address: $manager.personViewModel.address).anyView)
                }
                
                Section("Personal Informations") {
                    Text("Email").badge(manager.personViewModel.email)
                    Text("Phone").badge(manager.personViewModel.phone)
                }
                
                Section {
                    Button("Verify Email"){
                        
                    }.disabled(manager.personViewModel.hasEmailVerified)
                    
                    Button("Reset Password"){
                        
                    }
                    Button("Deactivate Account"){
                        
                    }
                }
            }
            .navigationTitle("Update Profile")
            .navigationBarItems(leading: navLeadingView, trailing: navTrailingView)
            .fullScreenCover(isPresented: $manager.showImagePickerCropper) {
                ImagePickerCropperView(onPick: { image in
                    manager.uploadImage(image: image)
                }, shape: .circle(maskOnly: false), ratio: .canUseMultiplePresetFixedRatio(defaultRatio: 1))
            }
        }
    }
    
    private var imageView: some View {
        PersonImageView(manager.personViewModel.photoUrl, .big)
            .onTapGesture {
                manager.showImagePickerCropper = true
            }
    }
    
    private var navTrailingView: some View {
        HStack {
            Button("Save") {
                manager.save()
                presentationMode.wrappedValue.dismiss()
            }.disabled(!manager.personViewModel.hasChanges)
        }
    }
    private var navLeadingView: some View {
        HStack {
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

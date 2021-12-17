//
//  UserProfileUpdateManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import UIKit
import FirebaseStorage
import SwiftUI

class UserProfileUpdateManager: ObservableObject {
    
    @Published var showImagePickerCropper = false
    
    @Published var personViewModel: PersonViewModel
    
    init(personViewModel: PersonViewModel) {
        self.personViewModel = personViewModel
    }
    
    func save() {
        personViewModel.update()
    }
    
    func uploadImage(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            return
        }

        let reference = Storage.storage().reference(withPath: "users").child("\(personViewModel.id)")

        reference.putData(data, metadata: nil) { (meta, error) in
            if let error = error {
                print(error)
                return
            }
            reference.downloadURL { (url, error) in
                if let error = error {
                    print(error)
                    return
                }
                if let url = url {
                    self.personViewModel.photoUrl = url.absoluteString
                }
            }
        }
    }
}

//
//  PeopleViewModel.swift
//  MyBike
//
//  Created by Aung Ko Min on 11/11/21.
//

import Combine
import Firebase

class CurrentUserViewModel: PersonViewModel {
    
    var hasChanges: Bool {
        return person.name != name || person.photoUrl != photoUrl || person.userMetadata.isEmailVerified != hasEmailVerified || person.address != address || ratings != person.ratings || phone != person.phone
    }
    
    func update() {
        guard hasChanges else { return }
        var new = person
        new.name = name
        new.email = email
        new.photoUrl = photoUrl
        new.userMetadata.isEmailVerified = hasEmailVerified
        new.address = address
        new.ratings = ratings
        new.phone = phone
        personRepo.update(new)
        self.person = new
    }
    
    func uploadImage(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            return
        }

        let reference = Storage.storage().reference(withPath: "users").child("\(self.id)")

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
                    self.photoUrl = url.absoluteString
                }
            }
        }
    }
}

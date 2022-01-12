//
//  CurrentUserViewModel+Actions.swift
//  MyBike
//
//  Created by Aung Ko Min on 26/12/21.
//

import UIKit
import FirebaseStorage

extension CurrentUserViewModel {
    
    enum CurrentUserAction {
        case uploadImage(_ image: UIImage, _ done: (URL?, Error?) -> Void)
        case updateHistory(_ historyType: Person.ViewedHistory.ViewedHistoryType, _ actionType: ActionType)
    }
    
    func setAction(_ action: CurrentUserAction) {
        switch action {
        case .uploadImage(let image, let done):
            self.uploadImage(image, done)
        case .updateHistory(let type, let actionType):
            updateHistor(historyType: type, actionType: actionType)
        }
    }
    
    var hasChanges: Bool {
        return person.name != name || person.photoUrl != photoUrl || person.userMetadata.isEmailVerified != hasEmailVerified || person.address != address || ratings != person.ratings || phone != person.phone
    }
}


extension CurrentUserViewModel {

    
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
    
    private func uploadImage(_ image: UIImage, _ done: @escaping (URL?, Error?) -> Void) {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            return
        }

        let reference = Storage.storage().reference(withPath: "users").child("\(self.id)")

        reference.putData(data, metadata: nil) { (meta, error) in
            if let error = error {
                done(nil, error)
                return
            }
            reference.downloadURL { (url, error) in
                if let error = error {
                    done(nil, error)
                    return
                }
                if let url = url {
                    self.photoUrl = url.absoluteString
                    done(url, nil)
                }
            }
        }
    }
}

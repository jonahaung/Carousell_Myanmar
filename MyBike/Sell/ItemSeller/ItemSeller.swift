//
//  BikeSeller.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import Firebase
import FirebaseFirestore
import FirebaseStorage

class ItemSeller: ObservableObject {

    func publish(sellingItem: SellingItem, person: Person,_ done: @escaping () -> Void) {
        guard sellingItem.validate() else {
            return
        }
        uploadImages(sellingItem: sellingItem) { urlStrings in
            let item = sellingItem.createItem(person: person, urls: urlStrings)
            ItemRepository.shared.update(item) {_ in
                DispatchQueue.main.async {
                    AppAlertManager.shared.alert = AlertObject.init("Item published", buttonText: "Done", action: done)
                }
            }
        }
    }

    private func uploadImages(sellingItem: SellingItem, _ done: @escaping ([String]) -> Void) {
        let bikeStorage = Storage.storage().reference(withPath: "bikes")
        
        let storage = bikeStorage.child(sellingItem.bikeId)

        var urls = [String]()

        let group = DispatchGroup()
        
        for (i, images) in sellingItem.images.enumerated() {
            group.enter()
            guard let data = images.image?.jpegData(compressionQuality: 0.8) else {
                group.leave()
                break
            }
            let reference = storage.child("\(i)")
            reference.putData(data, metadata: nil) { (meta, error) in
                if let error = error {
                    print(error)
                    group.leave()
                    return
                }
                reference.downloadURL { (url, error) in
                    if let error = error {
                        print(error)
                        group.leave()
                        return
                    }
                    if let url = url {
                        urls.insert(url.absoluteString, at: 0)
                    }
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            done(urls)
        }
    }
}


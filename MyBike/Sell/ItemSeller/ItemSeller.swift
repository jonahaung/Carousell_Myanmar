//
//  BikeSeller.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

class ItemSeller: ObservableObject {
    
    @Published var sellingImages = [SellingImage]()
    @Published var showLoading = false
    @Published var dealType = Item.DealType.Sell
    @Published var category = Category.none
    @Published var condition = Item.Condition.none
    @Published var title = ""
    @Published var detailText = ""
    @Published var price = ""
    @Published var address = Item.Address.none
    
    private let repository = ItemRepository()

    func publish(person: Person,_ done: @escaping () -> Void) {
        guard sellingImages.count > 0 else {
            AppAlertManager.shared.alert = AlertObject("Photos are empty")
            return
        }
        if title.isEmpty {
            AppAlertManager.shared.alert = AlertObject("Title shouldn't be empty")
            return
        }
        if !category.isSelected {
            AppAlertManager.shared.alert = AlertObject("Category is not selected yet")
            return
        }
        if !condition.isSelected {
            AppAlertManager.shared.alert = AlertObject("Condition is not selected yet")
            return
        }
        
        if detailText.isEmpty {
            AppAlertManager.shared.alert = AlertObject("Detail text shouldn't be empty")
            return
        }
        if price.isEmpty {
            AppAlertManager.shared.alert = AlertObject("Price shouldn't be empty")
            return
        }
        if address.isEmpty {
            AppAlertManager.shared.alert = AlertObject("Location shouldn't be empty")
            return
        }
        showLoading = true

        let bikeStorage = Storage.storage().reference(withPath: "bikes")
        let bikeId = UUID().uuidString
        let storage = bikeStorage.child(bikeId)

        var urls = [String]()

        let group = DispatchGroup()
        
        for (i, sellingImage) in sellingImages.enumerated() {

            group.enter()

            guard let data = sellingImage.image?.jpegData(compressionQuality: 0.8) else {
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
            self.addBike(id: bikeId, urls: urls, person: person, done)
        }
    }

    private func addBike(id: String, urls: [String], person: Person, _ done: @escaping () -> Void) {
        let item = Item(_id: id, _title: self.title, _category: self.category, _description: self.detailText, _price: Int(self.price) ?? 0, _dealType: self.dealType, _condition: self.condition, _person: person, _imageURLs: urls, _address: address)
        
        self.repository.add(item) {
            DispatchQueue.main.async {
                self.showLoading = false
                AppAlertManager.shared.alert = AlertObject.init("Item published", buttonText: "Done", action: done)
            }
        }
        
    }
    
    var isValidated: Bool {
        return !sellingImages.isEmpty && category.isSelected && condition.isSelected && !title.isEmpty && !detailText.isEmpty && !price.isEmpty && !address.isEmpty
    }
    
    func onClose(_ done: @escaping () -> Void) {
        AppAlertManager.shared.alert = AlertObject("Are you sure you want to quit", buttonText: "Yes, Close & Exit", role: .destructive, action: done)
    }
}


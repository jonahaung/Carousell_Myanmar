//
//  BikeSeller.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import SwiftUI
import LoremSwiftum
import Firebase
import FirebaseFirestore
import FirebaseStorage

class ItemSeller: ObservableObject {
    
    enum FullScreenType: Identifiable {
        var id: FullScreenType { return self }
        case imagesPicker
    }
    
    @Published var sellingImages = [SellingImage]()
    @Published var showLoading = false
    @Published var fullScreenType: FullScreenType?
    @Published var dealType = DealType.Sell
    @Published var category = Category.none
    @Published var condition = Item.Condition.none
    @Published var title = ""
    @Published var detailText = ""
    @Published var price = ""
    @Published var address = Item.Address.none
    @Published var errorAlert: AlertObject?
    
    private let repository = ItemRepository()

    func publish(person: Person) {
        guard sellingImages.count > 0 else {
            errorAlert = AlertObject(title: "Photos are empty", message: "Please upload at least one photo of the selling item", action: {
                self.fullScreenType = .imagesPicker
            })
            return
        }
        if title.isEmpty {
            errorAlert = AlertObject(title: "Title shouldn't be empty")
            return
        }
        if !category.isSelected {
            errorAlert = AlertObject(title: "Category is not selected yet")
            return
        }
        if !condition.isSelected {
            errorAlert = AlertObject(title: "Condition is not selected yet")
            return
        }
        
        if detailText.isEmpty {
            errorAlert = AlertObject(title: "Detail text shouldn't be empty")
            return
        }
        if price.isEmpty {
            errorAlert = AlertObject(title: "Price shouldn't be empty")
            return
        }
        if address.isEmpty {
            errorAlert = AlertObject(title: "Location shouldn't be empty")
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
            self.addBike(id: bikeId, urls: urls, person: person)
        }
    }

    private func addBike(id: String, urls: [String], person: Person) {
        let item = Item(_id: id, _title: self.title, _category: self.category, _description: self.detailText, _price: Int(self.price) ?? 0, _dealType: self.dealType, _condition: self.condition, _person: person, _imageURLs: urls, _address: address)
        
        self.repository.add(item) {
            DispatchQueue.main.async {
                self.showLoading = false
                self.errorAlert = AlertObject(title: "Item Added Successfully")
            }
        }
        
    }
}


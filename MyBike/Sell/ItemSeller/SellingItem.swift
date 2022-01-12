//
//  SellingItem.swift
//  MyBike
//
//  Created by Aung Ko Min on 2/1/22.
//

import SwiftUI

struct SellingItem {
    
    var bikeId = UUID().uuidString
    var images = [SellingImage]()
    var title = ""
    var detailText = ""
    var price = ""
    var dealType = Item.ExchangeType.Sell
    var category = Category.none
    var condition = Item.Condition.None
    var address = Item.Address.none
    
}


extension SellingItem {
    
    func createItem(person: Person, urls: [String]) -> Item {
        var item = Item.empty
        item.id = bikeId
        item.title = title
        item.category = category
        item.description = detailText
        if let double = Double(price) {
            item.price = double
        }
        item.condition = condition
        item.seller = person.briefPerson()
        if !urls.isEmpty {
            item.images = .init(urls: urls)
        }
        item.address = address
        
        return item
    }
    
    func validate() -> Bool {
        if images.isEmpty {
            AppAlertManager.shared.alert = AlertObject("Images shouldn't be empty")
            return false
        }
        if title.isEmpty {
            AppAlertManager.shared.alert = AlertObject("Title shouldn't be empty")
            return false
        }
        if !category.isSelected {
            AppAlertManager.shared.alert = AlertObject("Category is not selected yet")
            return false
        }
        if !condition.isSelected {
            AppAlertManager.shared.alert = AlertObject("Condition is not selected yet")
            return false
        }
        
        if detailText.isEmpty {
            AppAlertManager.shared.alert = AlertObject("Detail text shouldn't be empty")
            return false
        }
        if price.isEmpty || Double(price) == nil {
            AppAlertManager.shared.alert = AlertObject("Price shouldn't be empty")
            return false
        }
        if address.isEmpty {
            AppAlertManager.shared.alert = AlertObject("Location shouldn't be empty")
            return false
        }
        return true
    }
    
    var isValidated: Bool {
        return !images.isEmpty && !category.isEmpty && !condition.isEmpty && !address.isEmpty && !title.isEmpty && !detailText.isEmpty && !price.isEmpty
    }
    
    var isEmpty: Bool {
        return images.isEmpty && category.isEmpty && condition.isEmpty && address.isEmpty && title.isEmpty && detailText.isEmpty && price.isEmpty
    }
    
    mutating func reset() {
        self = SellingItem()
    }
}

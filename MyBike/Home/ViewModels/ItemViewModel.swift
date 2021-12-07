//
//  BikeViewModel.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import Combine
import SwiftUI
import Firebase

class ItemViewModel: ObservableObject, Identifiable {
    
    var id: String? { return item.id }
    
    @Published var item: Item
    
    var price: String { return "$\(item.price)"}
    
    private let bikeRepository = ItemRepository()
    
    init(item: Item) {
        self.item = item
    }
    
    func updateViewCount() {
        var newItem = item
        let count = newItem.views.count
        var uids = item.views.uids
        if !newItem.views.hasViewed, let uid = Auth.auth().currentUser?.uid {
            uids.append(uid)
        }
        
        newItem.views = Item.Views(count: count + 1, uids: uids)
        bikeRepository.update(newItem) {
            self.item = newItem
        }
    }
    
    func addComments(comment: Item.Comment, _ completion: @escaping () -> Void) {
        var newBike = item
        let comments = newBike.comments
        newBike.comments = comments + [comment]
        bikeRepository.update(newBike) {
            self.item = newBike
            completion()
        }
    }
    func delete() {
        bikeRepository.remove(item) {
            
        }
    }
    
    static func getMockData(for i: Int) -> [ItemViewModel] {
        return (0..<i).map{ _ in ItemViewModel(item: Item.mock() ) }
    }
}

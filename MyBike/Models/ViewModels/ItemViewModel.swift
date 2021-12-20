//
//  BikeViewModel.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import Combine
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class ItemViewModel: ObservableObject, Identifiable {
    
    var id: String? { return item.id }
    
    @Published var item: Item
    @Published var person: Person
    
    init(item: Item, person: Person) {
        self.item = item
        self.person = person
    }
}

extension ItemViewModel {
    func toggleFavourite() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var newItem = self.item
        var uids = newItem.favourites.uids
        
        if newItem.favourites.isFavourite {
            if let index = uids.firstIndex(of: uid) {
                uids.remove(at: index)
            }
        } else {
            uids.append(uid)
        }
        newItem.favourites = Item.Favourites(count: uids.count, uids: uids)
        ItemRepository.shared.update(newItem) {
            Vibration.success.vibrate()
        }
    }
    
    func updateViewCount() {
        var newItem = item
        let count = newItem.views.count
        var uids = item.views.uids
        if !newItem.views.hasViewed, let uid = Auth.auth().currentUser?.uid {
            uids.append(uid)
        }
        
        newItem.views = Item.Views(count: count + 1, uids: uids)
        ItemRepository.shared.update(newItem)
    }
    
    func addComments(comment: Item.Comment, _ completion: @escaping () -> Void) {
        var newItem = item
        let comments = newItem.comments
        newItem.comments = comments + [comment]
        ItemRepository.shared.update(newItem)
    }
    func delete() {
        ItemRepository.shared.remove(item) {
            
        }
    }
    
    static func getMockData(for i: Int) -> [ItemViewModel] {
        return (0..<i).map{ _ in ItemViewModel(item: Item.mock(), person: Person.mock ) }
    }
}

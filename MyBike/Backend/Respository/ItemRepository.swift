//
//  BikeRepository.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import FirebaseFirestore
import Combine
import FirebaseFirestoreSwift

class ItemRepository: ObservableObject {
    
    static let shared = ItemRepository()
    private let path: String = "bikes"
    private let store = Firestore.firestore()
    
    
    func add(_ bike: Item, completion: @escaping ()-> Void) {
        do {
            _ = try store.collection(path).addDocument(from: bike, completion: { error in
                completion()
            })
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription).")
        }
    }
    
    func update(_ bike: Item, completion: (()-> Void)? = nil) {
        guard let bikeId = bike.id else { return }
        do {
            try store.collection(path).document(bikeId).setData(from: bike, completion: { error in
                if error == nil {
                    AppBackendManager.shared.refresh(bike)
                }
                completion?()
            })
        } catch {
            fatalError("Unable to update card: \(error.localizedDescription).")
        }
    }
    
    func remove(_ bike: Item, completion: @escaping ()-> Void) {
        guard let bikeId = bike.id else { return }
        store.collection(path).document(bikeId).delete { error in
            if let error = error {
                print("Unable to remove card: \(error.localizedDescription)")
            }
        }
    }
    
    func get(_ item: Item, completion: @escaping (Item?)-> Void) {
        guard let bikeId = item.id else { return }
        store.collection(path).document(bikeId).getDocument { snap, error in
            let item = try? snap?.data(as: Item.self)
            completion(item)
        }
    }
}

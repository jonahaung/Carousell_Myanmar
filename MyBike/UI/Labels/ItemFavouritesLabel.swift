//
//  ItemFavouritesLabel.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/12/21.
//

import SwiftUI
import Firebase

struct ItemFavouritesLabel: View {
    
    @ObservedObject private var itemViewModel: ItemViewModel
    
    init(_ _itemViewModel: ItemViewModel) {
        itemViewModel = _itemViewModel
    }
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: itemViewModel.item.favourites.isFavourite ? "heart.fill" : "heart")
                .foregroundColor(itemViewModel.item.favourites.isFavourite ? .pink : .gray)
            Text("\(itemViewModel.item.favourites.count)")
                .font(.caption)
        }
        .foregroundStyle(.secondary)
        .onTapGesture {
            toggleFavourite()
        }
    }
    
    private func toggleFavourite() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var newItem = itemViewModel.item
        var uids = newItem.favourites.uids
        
        if newItem.favourites.isFavourite {
            if let index = uids.firstIndex(of: uid) {
                uids.remove(at: index)
            }
        } else {
            uids.append(uid)
        }
        newItem.favourites = Item.Favourites(count: uids.count, uids: uids)
        ItemRepository.shared.update(newItem)
    }
}

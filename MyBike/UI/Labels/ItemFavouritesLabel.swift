//
//  ItemFavouritesLabel.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/12/21.
//

import SwiftUI
import Firebase

struct ItemFavouritesLabel: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: itemViewModel.item.favourites.isFavourite ? "heart.fill" : "heart")
                .foregroundColor(itemViewModel.item.favourites.isFavourite ? .pink : .gray)
            Text("\(itemViewModel.item.favourites.count)")
                .font(.caption)
        }
        .foregroundStyle(.secondary)
        .onTapGesture {
            Vibration.light.vibrate()
            itemViewModel.toggleFavourite()
        }
    }
}

//
//  BikeContextMenu.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/11/21.
//

import SwiftUI

struct ItemContextMenu: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel

    var body: some View {
        
        Button(action: {
            itemViewModel.toggleFavourite()
        }) {
            let text = itemViewModel.item.favourites.isFavourite ? "Remove from favourites" : "Add to favourites"
            let imageName = itemViewModel.item.favourites.isFavourite ? "heart.fill" : "heart"
            
            Label(text, systemImage: imageName)
        }
        
        Button(action: {
            itemViewModel.delete()
        }) {
            Label("Delete", systemImage: "trash.fill")
        }
    }
}

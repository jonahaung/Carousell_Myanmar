//
//  BikeContextMenu.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/11/21.
//

import SwiftUI

struct ItemContextMenu: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    @EnvironmentObject private var authService: AuthenticationService
    
    var body: some View {
        
        Button(action: {
            if let x = authService.currentUserViewModel {
                itemViewModel.setAction(.toggleFavourites(x))
            }
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

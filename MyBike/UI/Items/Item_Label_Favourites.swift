//
//  ItemFavouritesLabel.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/12/21.
//

import SwiftUI
import Firebase

struct Item_Label_Favourites: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    @EnvironmentObject private var authService: AuthenticationService
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: itemViewModel.item.favourites.isFavourite ? "suit.heart.fill" : "suit.heart")
                .foregroundColor(itemViewModel.item.favourites.isFavourite ? .red : .gray)
            Text("\(itemViewModel.item.favourites.count)")
                .font(.system(size: UIFont.smallSystemFontSize))
        }
        .foregroundStyle(.secondary)
        .onTapGesture {
            if let x = authService.currentUserViewModel {
                itemViewModel.setAction(.toggleFavourites(x))
            }
            
        }
    }
}

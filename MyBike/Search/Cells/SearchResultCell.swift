//
//  BikeView.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import SwiftUI

struct SearchResultCell: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        HStack {
            ItemImageView(itemViewModel.item.images.firstImage, .small)
            VStack(alignment: .leading, spacing: 8) {
                Text(itemViewModel.item.title.capitalized)
                    .textStyle(style: .title_headline)
                    .foregroundColor(.steam_gold)
                
                HStack {
                    Text("$\(itemViewModel.item.price)")
                        .textStyle(style: .title_title)
                    Spacer()
                    Text(itemViewModel.item.condition.description)
                        .textStyle(style: .link_small)
                }
                SellerInfoLabel(itemViewModel)
                
                HStack {
                    ItemFavouritesLabel()
                    ItemViewsLabel()
                    
                    Spacer()
                    Text(itemViewModel.item.date_added)
                        .textStyle(style: .link_small)
                    
                }
                .foregroundColor(.secondary)
            }.tapToPush(ItemDetailView().environmentObject(itemViewModel).anyView)
        }
    }
}

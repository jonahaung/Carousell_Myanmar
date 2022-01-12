//
//  BikeGridCell.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/11/21.
//

import SwiftUI

struct Item_Cell_Grid: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ItemImageView(itemViewModel.item.images.firstImage, .medium)
                .aspectRatio(1/PosterStyle.aspectRatio, contentMode: .fill)
                .cornerRadius(5)
                .tapToPush(ItemDetailView().environmentObject(itemViewModel))
                .contextMenu{ ItemContextMenu().environmentObject(itemViewModel) }
            HStack {
                Text(itemViewModel.item.price.toCurrencyFormat())
                    .font(.FjallaOne())
                Spacer()
                
                let element = itemViewModel.item.condition.uiElements()
                
                Image(systemName: element.iconName)
                    .imageScale(.small)
            }
            .foregroundColor(.white)
            .padding(5)
        }
        
    }
}

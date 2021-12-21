//
//  BikeGridCell.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/11/21.
//

import SwiftUI

struct ItemGridCell: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ItemImageView(itemViewModel.item.images.firstImage, .medium)
                .tapToPush(ItemDetailView().environmentObject(itemViewModel).anyView)
                .cornerRadius(5)
            HStack {
                Text("$\(itemViewModel.item.price)")
                    .font(.FjallaOne(UIFont.systemFontSize))
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: itemViewModel.item.condition.batteryIcon)
                    .foregroundColor(itemViewModel.item.condition.color)
                    .imageScale(.small)
            }
            .padding(5)
        }
        .contextMenu{ ItemContextMenu().environmentObject(itemViewModel) }
    }
}

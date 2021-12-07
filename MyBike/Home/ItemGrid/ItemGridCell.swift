//
//  BikeGridCell.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/11/21.
//

import SwiftUI

struct ItemGridCell: View {
    
    @ObservedObject var itemViewModel: ItemViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ZStack(alignment: .bottomTrailing) {
                ItemImageView(itemViewModel.item.images.firstImage, .medium)
                    .tapToPush(ItemDetailView(itemViewModel: itemViewModel).anyView)
                HStack(alignment: .bottom) {
                    Text(itemViewModel.price)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Image(systemName: "circle.fill")
                        .foregroundColor(itemViewModel.item.condition.color)
                        .imageScale(.small)
                }
                .padding(5)
                
            }
            Text(itemViewModel.item.title.capitalized)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .padding(.horizontal, 5)
            SellerInfoLabel(itemViewModel)
                .font(.FHACondFrenchNC(size: 12))
            Spacer()
        }
        .frame(width: PosterStyle.Size.medium.width, height: PosterStyle.Size.medium.height * 1.5)
        .foregroundStyle(.primary)
        .background(Rectangle().stroke(Color.quaternaryLabel, lineWidth: 0.5))
    }
}

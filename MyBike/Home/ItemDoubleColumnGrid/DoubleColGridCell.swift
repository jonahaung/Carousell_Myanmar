//
//  DoubleColGridCell.swift
//  MyBike
//
//  Created by Aung Ko Min on 2/12/21.
//

import SwiftUI

struct DoubleColGridCell: View {
    
    @StateObject var itemViewModel: ItemViewModel
    
    var body: some View {
        SingleAxisGeometryReader { width in
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(itemViewModel.item.seller.userName)
                        .font(.FHACondFrenchNC(size: 13))
                        .tapToPush(Text("Person").anyView)
                        
                    HStack(spacing: 0) {
                        let random = Int.random(in: 0..<6)
                        ForEach(0..<random) {_ in
                            Image(systemName: "star.fill")
                        }
                    }
                    .font(.caption)
                    
                    .foregroundColor(.secondary)
                }
                ZStack(alignment: .bottom) {
                    ItemImageView(itemViewModel.item.images.firstImage, .custom(width))
                        .tapToPush(ItemDetailView(itemViewModel: itemViewModel).anyView)
                    HStack{
                        PersonImageView(itemViewModel.item.seller.photoUrl, .tinyPersonImage)
                        Spacer()
                        Image(systemName: "circle.fill")
                            .foregroundColor(itemViewModel.item.condition.color)
                            
                    }.padding(3)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text(itemViewModel.item.title.capitalized)
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .lineLimit(2)
                    HStack(alignment: .top) {
                        Text(itemViewModel.price)
                            .textStyle(style: .title_regular)
                        Spacer()
                        ItemFavouritesLabel(itemViewModel)
                    }
                }
                .padding(.horizontal, 2)
            }
            .frame(width: width, height: width * 1.5)
            .imageScale(.small)
            .contextMenu{ ItemContextMenu(itemViewModel: itemViewModel) }
        }
    }
}

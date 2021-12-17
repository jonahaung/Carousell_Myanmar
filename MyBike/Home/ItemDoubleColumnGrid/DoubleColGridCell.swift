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
            VStack(alignment: .leading) {
                ZStack(alignment: .bottom) {
                    ItemImageView(itemViewModel.item.images.firstImage, .medium)
                        .tapToPush(ItemDetailView(itemViewModel: itemViewModel).anyView)
                        .cornerRadius(7)
                        
                    HStack{
                        PersonImageView(itemViewModel.item.seller.photoUrl, .tinyPersonImage)
                        Spacer()
                        Image(systemName: "circle.fill")
                            .foregroundColor(itemViewModel.item.condition.color)
                        
                    }.padding(3)
                }
                VStack(alignment: .leading, spacing: 3) {
                    HStack(alignment: .top) {
                        Text("$\(itemViewModel.item.price)")
                            .font(.FjallaOne(16))
                        Spacer()
                        ItemFavouritesLabel(itemViewModel)
                    }
                    Text(itemViewModel.item.title.capitalized)
                        .font(.FHACondFrenchNC(14))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                    
                    HStack {
                        Text(itemViewModel.item.seller.userName)
                        HStack(spacing: 0) {
                            let random = Int.random(in: 0..<6)
                            ForEach(0..<random, id:\.self) {_ in
                                Image(systemName: "star.fill")
                            }
                        }
                        .font(.system(size: 8))
                        .foregroundStyle(.tertiary)
                    }
                    .font(.FHACondFrenchNC(13))
                    .foregroundStyle(.secondary)
                    Divider()
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                }
            }
            .contextMenu{ ItemContextMenu(itemViewModel: itemViewModel) }
            
        }
    }
}

//
//  DoubleColGridCell.swift
//  MyBike
//
//  Created by Aung Ko Min on 2/12/21.
//

import SwiftUI

struct DoubleColGridCell: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        SingleAxisGeometryReader { width in
            VStack(alignment: .leading) {
                ZStack(alignment: .bottom) {
                    ItemImageView(itemViewModel.item.images.firstImage, .medium)
                        .tapToPush(ItemDetailView().environmentObject(itemViewModel).anyView)
                        .cornerRadius(7)
                    
                    HStack{
                        PersonImageView(itemViewModel.person.photoUrl, .tinyPersonImage)
                        Spacer()
                        Image(systemName: itemViewModel.item.condition.batteryIcon)
                            .foregroundColor(.white)
                            .shadow(radius: 3)
//                            .foregroundColor(itemViewModel.item.condition.color)
                        
                    }.padding(3)
                }
                VStack(alignment: .leading, spacing: 3) {
                    HStack(alignment: .top) {
                        Text("$\(itemViewModel.item.price)")
                            .font(.FjallaOne(16))
                        Spacer()
                        ItemFavouritesLabel()
                    }
                    Text(itemViewModel.item.title.capitalized)
                        .font(.FHACondFrenchNC(14))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                    
                    HStack {
                        Text(itemViewModel.person.userName)
                        RatingView().environmentObject(CurrentUserViewModel(person: itemViewModel.person))
                        .font(.system(size: 8))
                    }
                    .font(.FHACondFrenchNC(13))
                    .foregroundStyle(.secondary)
                    Divider()
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                }
            }
            .contextMenu{ ItemContextMenu().environmentObject(itemViewModel) }
        }
    }
}

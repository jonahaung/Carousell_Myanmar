//
//  DoubleColGridCell.swift
//  MyBike
//
//  Created by Aung Ko Min on 2/12/21.
//

import SwiftUI

struct ItemListCell: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                itemImageView
                itemImageOverlayView
            }
            titleView
        }
        
    }
    
    private var itemImageView: some View {
        ItemImageView(itemViewModel.item.images.firstImage, .medium)
            .aspectRatio(1/PosterStyle.aspectRatio, contentMode: .fill)
            .cornerRadius(7)
            .tapToPush(ItemDetailView().environmentObject(itemViewModel))
            .contextMenu{ ItemContextMenu().environmentObject(itemViewModel) }
    }
    
    private var itemImageOverlayView: some View {
        HStack{
            if let urlString = itemViewModel.person.photoUrl {
                PersonImageView(urlString, .tinyPersonImage)
                Spacer()
            }
            
            let element = itemViewModel.item.condition.uiElements()
            Image(systemName: element.iconName)
                .foregroundColor(.white)
                .shadow(radius: 3)
            
        }.padding(3)
        
    }
    
    private var titleView: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack(alignment: .top) {
                Text(itemViewModel.item.price.toCurrencyFormat())
                    .font(.FjallaOne())
                Spacer()
                Item_Label_Views()
                    .imageScale(.small)
                Item_Label_Favourites()
                    .imageScale(.medium)
            }
            Text(itemViewModel.item.title.capitalized)
                .font(.FHACondFrenchNC(14))
                .foregroundStyle(.secondary)
            
            HStack {
                Text(itemViewModel.person.userName)
                
                Person_Profile_Rating(personViewModel: CurrentUserViewModel(person: itemViewModel.person))
                .font(.system(size: 8))
            }
            .font(.FHACondFrenchNC(UIFont.smallSystemFontSize))
            .foregroundStyle(.secondary)
            
            Divider()
                .padding(.horizontal)
                .padding(.vertical, 4)
        }
        .lineLimit(1)
    }
}

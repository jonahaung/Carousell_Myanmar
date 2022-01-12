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
                
                
                HStack {
                    Text("$\(itemViewModel.item.price)")
                        
                    Spacer()
                    Text(itemViewModel.item.condition.description)
                        
                }
                SellerInfoLabel(itemViewModel)
                
                HStack {
                    Item_Label_Favourites()
                    Item_Label_Views()
                    
                    Spacer()
                    Text(itemViewModel.item.dateAdded.relativeString)
                       
                    
                }
                .foregroundColor(.secondary)
            }.tapToPush(ItemDetailView().environmentObject(itemViewModel))
        }
    }
}

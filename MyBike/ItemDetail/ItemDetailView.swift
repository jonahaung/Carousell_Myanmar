//
//  BikeDetailView.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/11/21.
//

import SwiftUI

struct ItemDetailView: View {
    
    @StateObject var itemViewModel: ItemViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ItemImagesSection(itemViewModel: itemViewModel)
            ItemSectionOne(itemViewModel: itemViewModel)
            ItemKeywordsSection(itemViewModel: itemViewModel)
            ItemSectionTwo(itemViewModel: itemViewModel)
            ItemSellerSection(itemViewModel: itemViewModel)
            ItemLocationSection(itemViewModel: itemViewModel)
            ItemBuySection(itemViewModel: itemViewModel)
            ItemsGridsSection(itemViewModel, .search(.Seller(itemViewModel.item.seller.userName)), .medium)
//            ItemsGridsSection(itemViewModel, .search(.Keywords(itemViewModel.item.keywords)), .medium)
        }
        .background(Color.groupedTableViewBackground)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Detail")
        .task { itemViewModel.updateViewCount() }
    }
}


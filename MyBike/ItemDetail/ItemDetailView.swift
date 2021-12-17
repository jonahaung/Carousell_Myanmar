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
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false) {
                ItemImagesSection(itemViewModel: itemViewModel, geo: geo)
                ItemSectionOne(itemViewModel: itemViewModel)
                ItemKeywordsSection(itemViewModel: itemViewModel)
                ItemSectionTwo(itemViewModel: itemViewModel)
                ItemSellerSection(itemViewModel: itemViewModel)
                ItemLocationSection(itemViewModel: itemViewModel)
                ItemBuySection(itemViewModel: itemViewModel)
                ItemsGridsSection(itemViewModel, .search([.Seller(itemViewModel.item.seller.userName)]), .medium)
                VStack {
                    ItemsHeaderView(.search([.Category(itemViewModel.item.category)]))
                    DoubleColGrid(.search([.Category(itemViewModel.item.category)]))
                }
            }
            .background(Color.groupedTableViewBackground)

            .navigationTitle("Detail")
            .task { itemViewModel.updateViewCount() }
        }
        
    }
}


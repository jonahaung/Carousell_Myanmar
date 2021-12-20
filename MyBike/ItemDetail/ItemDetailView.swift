//
//  BikeDetailView.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/11/21.
//

import SwiftUI

struct ItemDetailView: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ItemImagesSection()
            ItemSectionOne()
            ItemKeywordsSection()
            ItemSectionTwo()
            ItemSellerSection()
            ItemLocationSection()
            ItemBuySection()
            ItemsGridsSection(.search([.Seller(itemViewModel.person.userName)]))
            VStack {
                ItemsHeaderView(.search([.Category(itemViewModel.item.category)]))
                DoubleColGrid(.search([.Category(itemViewModel.item.category)]))
            }
        }
        .background(Color.groupedTableViewBackground)
        .navigationTitle("Detail")
        .task {
            itemViewModel.updateViewCount()
        }
    }
}

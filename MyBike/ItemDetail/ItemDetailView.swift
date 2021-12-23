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
            ItemDetail_Section_Images()
            ItemDetail_Section_One()
            ItemDetail_Section_Keywords()
            ItemDetail_Section_Two()
            ItemDetail_Section_Seller()
            ItemDetail_Section_Location()
            ItemDetail_Section_Buy()
            ItemDetail_Section_SimilierItems(.search([.Seller(itemViewModel.person.userName)]))
            VStack {
                Item_Collection_Header(.search([.Category(itemViewModel.item.category)]))
                DoubleCol_Grid()
                    .environmentObject(AppBackendManager.shared.itemBackendManager(for: .search([.Category(itemViewModel.item.category)])))
            }
        }
        .background(Color.groupedTableViewBackground)
        .navigationTitle("Detail")
        .task {
            itemViewModel.updateViewCount()
        }
    }
}

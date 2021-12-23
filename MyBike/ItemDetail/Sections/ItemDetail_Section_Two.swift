//
//  ItemSectionTwo.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemDetail_Section_Two: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        Group {
            HStack {
                if let parent = itemViewModel.item.category.parentNode {
                    Text(parent.title)
                        .tapToPushItemsList(.search([.Category(parent)]))
                } else {
                    Text("Category")
                }
                Spacer()
                Text(itemViewModel.item.category.title)
                    .tapToPushItemsList(.search([.Category(itemViewModel.item.category)]))
            }
            Divider()
            HStack {
                Text("\(itemViewModel.item.comments.count) comments")
                    .tapToPush(Item_Details_Comments(itemViewModel: itemViewModel).anyView)
                Spacer()
                Text(itemViewModel.item.date_added)
                    .italic()
                    .foregroundColor(.secondary)
                
            }
            Divider()
            HStack {
                Text("Deal type")
                Spacer()
                Text(itemViewModel.item.dealType.description)
                    .foregroundColor(.secondary)
                
            }
        }.insetGroupSectionStyle(rowSpacing: 8)
    }
}

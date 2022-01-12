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
        VStack {
            
            FormCell("Category I"){
                Text(itemViewModel.item.category.title)
                    .tapToPushItemsList(.search([.Category(itemViewModel.item.category)]))
            }
            
            if let parent = itemViewModel.item.category.parentNode {
                FormCell("Category II"){
                    Text(parent.title)
                        .tapToPushItemsList(.search([.Keywords([parent.title])]))
                }
            }
        
            FormCell("Comments"){
                Text("\(itemViewModel.item.comments.count) comments")
                    .tapToPush(Item_Details_Comments(itemViewModel: itemViewModel))
            }
            
            FormCell("Date Added") {
                Text(itemViewModel.item.dateAdded.relativeString)
                    .tapToPush(Text(""))
            }
            FormCell("Deal Type") {
                Text(itemViewModel.item.exchangeType.rawValue)
                    .tapToPush(Text(""))
            }
            
            if let status = itemViewModel.item.status {
                FormCell("Progress") {
                    Text(status.rawValue).tapToPresent(Text(""))
                        
                }
            }
            
        }.insetGroupSectionStyle()
    }
}

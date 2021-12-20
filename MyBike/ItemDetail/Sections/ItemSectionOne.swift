//
//  ItemSectionOne.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemSectionOne: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                Text(itemViewModel.item.title.capitalized)
                Spacer()
                Text("$\(itemViewModel.item.price)")
            }
            .textStyle(style: .title_headline)
          
            HStack{
                ItemFavouritesLabel()
                ItemViewsLabel()
                Spacer()
                Text(itemViewModel.item.condition.description)
                    .tapToPushItemsList(.search([.Condition(itemViewModel.item.condition)]))
            }
        
            ItemDescriptionRow(item: itemViewModel.item)
            
        }.insetGroupSectionStyle()
    }
}

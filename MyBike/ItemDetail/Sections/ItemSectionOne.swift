//
//  ItemSectionOne.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemSectionOne: View {
    
    @StateObject var itemViewModel: ItemViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack{
                Text(itemViewModel.item.title.capitalized)
                Spacer()
                Text(itemViewModel.price)
            }
            .textStyle(style: .title_headline)
          
            HStack{
                ItemFavouritesLabel(itemViewModel)
                ItemViewsLabel(itemViewModel)
                Spacer()
                Text(itemViewModel.item.condition.description)
                    .tapToPushItemsList(.search(.Condition(itemViewModel.item.condition)))
            }
        
            ItemDescriptionRow(item: itemViewModel.item)
            
        }.insetGroupSectionStyle()
    }
}

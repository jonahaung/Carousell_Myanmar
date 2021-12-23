//
//  ItemSectionOne.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemDetail_Section_One: View {
    
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
                Item_Label_Favourites()
                Item_Label_Views()
                Spacer()
                Text(itemViewModel.item.condition.description)
                    .tapToPushItemsList(.search([.Condition(itemViewModel.item.condition)]))
            }
        
            Item_Details_Row_Description(item: itemViewModel.item)
            
        }.insetGroupSectionStyle()
    }
}

//
//  ItemKeywordsRow.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemDetail_Section_Keywords: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(itemViewModel.item.keywords) { keyword in
                        RoundedBadge(text: keyword, color: .steam_blue)
                            .foregroundColor(.white)
                            .tapToPushItemsList(.search([.Keywords([keyword])]))
                            
                    }
                }.padding(.leading)
            }
        }
    }
}

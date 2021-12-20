//
//  ItemKeywordsRow.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemKeywordsSection: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(itemViewModel.item.keywords) { keyword in
                        RoundedBadge(text: keyword, color: Color(uiColor: .random))
                            .foregroundColor(.white)
                            .tapToPushItemsList(.search([.Keywords([keyword])]))
                            
                    }
                }.padding(.leading)
            }
        }
    }
}

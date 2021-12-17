//
//  ItemSellerSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemSellerSection: View {
    
    @StateObject var itemViewModel: ItemViewModel
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    PersonImageView(itemViewModel.item.seller.photoUrl, .medium)
                    VStack {
                        Text(itemViewModel.item.seller.userName)
                        PopularityBadge(score: Int.random(in: 1..<99))
                    }
                    Spacer()
                }
            }
        }.insetGroupSectionStyle()
    }
}

//
//  ItemSellerSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemSellerSection: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        Group {
            if let person = itemViewModel.person {
                VStack {
                    HStack {
                        PersonImageView(person.photoUrl, .medium)
                        VStack {
                            Text(person.userName)
                            PopularityBadge(score: Int.random(in: 1..<99))
                        }
                        Spacer()
                    }
                }
            }
            
        }
        .insetGroupSectionStyle()
    }
}

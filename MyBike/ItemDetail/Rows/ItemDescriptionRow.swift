//
//  ItemDescriptionView.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemDescriptionRow: View {
    
    let item: Item
    
    @State private var isOverviewExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(self.isOverviewExpanded ? nil : 4)
                .onTapGesture {
                    withAnimation{
                        self.isOverviewExpanded.toggle()
                    }
                }
            Button(action: {
                withAnimation {
                    self.isOverviewExpanded.toggle()
                }
            }, label: {
                Text(self.isOverviewExpanded ? "Less" : "Read more")
            })
        }
    }
}

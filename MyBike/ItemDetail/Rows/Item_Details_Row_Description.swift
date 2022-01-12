//
//  ItemDescriptionView.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct Item_Details_Row_Description: View {
    
    let item: Item
    
    @State private var isOverviewExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.description)
                .lineLimit(self.isOverviewExpanded ? nil : 3)
                .onTapGesture(perform: toggle)
                .foregroundStyle(.secondary)
            
            Button(action: toggle) {
                Text(self.isOverviewExpanded ? "less" : "more ....")
                    .italic()
            }
        }
    }
    
    private func toggle() {
        withAnimation(.interactiveSpring()) {
            self.isOverviewExpanded.toggle()
        }
    }
}

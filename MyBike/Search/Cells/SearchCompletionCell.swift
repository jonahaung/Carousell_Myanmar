//
//  ItemSearchCell.swift
//  MyBike
//
//  Created by Aung Ko Min on 9/12/21.
//

import SwiftUI

struct SearchCompletionCell: View {
    
    @StateObject var itemViewModel: ItemViewModel
    
    var body: some View {
        Group {
            Text(itemViewModel.item.title.capitalized + "\n")
            +
            Text(itemViewModel.item.category.title.capitalized)
                .font(.footnote)
                .foregroundColor(.tertiaryLabel)
        }
    }
}

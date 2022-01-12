//
//  ItemViewsLabel.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/12/21.
//

import SwiftUI

struct Item_Label_Views: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        HStack(spacing: 1) {
            Image(systemName: "magnifyingglass")
            Text("\(itemViewModel.item.views.count)")
                .font(.system(size: UIFont.smallSystemFontSize))
        }.foregroundStyle(itemViewModel.item.views.hasViewed ? .secondary : .primary)
    }
}

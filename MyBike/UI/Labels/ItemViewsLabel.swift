//
//  ItemViewsLabel.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/12/21.
//

import SwiftUI

struct ItemViewsLabel: View {
    
    @ObservedObject private var itemViewModel: ItemViewModel
    
    init(_ _itemViewModel: ItemViewModel) {
        itemViewModel = _itemViewModel
    }
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: itemViewModel.item.views.hasViewed ? "eye.fill" : "eye")
            Text("\(itemViewModel.item.views.count)")
        }.foregroundStyle(.secondary)
    }
}

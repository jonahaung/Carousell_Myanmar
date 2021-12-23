//
//  DoubleColGridView.swift
//  MyBike
//
//  Created by Aung Ko Min on 2/12/21.
//

import SwiftUI

struct DoubleCol_Scroll: View {
    
    private let itemMenu: ItemMenu
    init(_ _itemMenu: ItemMenu) {
        itemMenu = _itemMenu
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            DoubleCol_Grid()
                .environmentObject(AppBackendManager.shared.itemBackendManager(for: itemMenu))
        }
        .navigationTitle(itemMenu.title)
        .background(Color.groupedTableViewBackground)
    }
}

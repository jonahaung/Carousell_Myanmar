//
//  DoubleColGridView.swift
//  MyBike
//
//  Created by Aung Ko Min on 2/12/21.
//

import SwiftUI

struct DoubleColGridView: View {
    
    private let itemMenu: ItemMenu
    
    init(_ itemMenu: ItemMenu) {
        self.itemMenu = itemMenu
    }
    
    var body: some View {
        VStack {
            ScrollView {
                DoubleColGrid(itemMenu)
            }
        }
        .background(Color.groupedTableViewBackground)
        .navigationTitle(itemMenu.title())
    }
}

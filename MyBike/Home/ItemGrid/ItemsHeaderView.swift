//
//  ItemsHeaderView.swift
//  MyBike
//
//  Created by Aung Ko Min on 10/12/21.
//

import SwiftUI

struct ItemsHeaderView: View {
    
    private let itemMenu: ItemMenu
    
    init(_ _menu: ItemMenu) {
        itemMenu = _menu
    }
    var body: some View {
        HStack {
            Text(itemMenu.title)
                .textStyle(style: .title_title)
            Spacer()
            Text("See all")
                .tapToPushItemsList(itemMenu)
        }
        .padding(.horizontal)
    }
}

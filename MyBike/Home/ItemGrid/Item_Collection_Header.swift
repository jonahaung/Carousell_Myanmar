//
//  ItemsHeaderView.swift
//  MyBike
//
//  Created by Aung Ko Min on 10/12/21.
//

import SwiftUI

struct Item_Collection_Header: View {
    
    private let itemMenu: ItemMenu
    private let showSeeAll: Bool
    
    init(_ _menu: ItemMenu, _showSeeAll: Bool = true) {
        itemMenu = _menu
        showSeeAll = _showSeeAll
    }
    var body: some View {
        HStack {
            Text(itemMenu.title)
                .textStyle(style: .title_title)
                .foregroundColor(.steam_gold)
            Spacer()
            if showSeeAll {
                Text("See all")
                    .tapToPushItemsList(itemMenu)
            }
        }
        .padding(.horizontal)
    }
}

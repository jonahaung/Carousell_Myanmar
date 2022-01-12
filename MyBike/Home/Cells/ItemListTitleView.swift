//
//  ItemsHeaderView.swift
//  MyBike
//
//  Created by Aung Ko Min on 10/12/21.
//

import SwiftUI

struct ItemListTitleView: View {
    
    private let itemMenu: ItemMenu
    private let showSeeAll: Bool
    
    init(_ _menu: ItemMenu, _showSeeAll: Bool = true) {
        itemMenu = _menu
        showSeeAll = _showSeeAll
    }
    var body: some View {
        HStack {
            Text(itemMenu.title)
                .font(.sectionTitleFont(20))
            Spacer()
            if showSeeAll {
                Text("See all")
                    .tapToPushItemsList(itemMenu)
            }
        }
        .padding(.horizontal)
    }
}


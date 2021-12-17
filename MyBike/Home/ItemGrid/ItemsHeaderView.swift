//
//  ItemsHeaderView.swift
//  MyBike
//
//  Created by Aung Ko Min on 10/12/21.
//

import SwiftUI

struct ItemsHeaderView: View {
    
    private let menu: ItemMenu
    
    init(_ _menu: ItemMenu) {
        menu = _menu
    }
    var body: some View {
        HStack {
            Text(menu.title).textStyle(style: .title_title)
            Spacer()
            Text("See all")
                .tapToPushItemsList(menu)
        }
        .padding(.horizontal)
    }
}

//
//  SectionWithItemTitleView.swift
//  MyBike
//
//  Created by Aung Ko Min on 12/1/22.
//

import SwiftUI

struct SectionWithItemTitleView<Content: View>: View {
    
    private let content: () -> Content
    private let itemMenu: ItemMenu
    private let showViewAll: Bool
    
    init(_ itemMenu: ItemMenu, showViewAll: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.itemMenu = itemMenu
        self.showViewAll = showViewAll
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(itemMenu.title)
                    .font(.sectionTitleFont(20))
                Spacer()
                if showViewAll {
                    Text("See all")
                        .tapToPushItemsList(itemMenu)
                }
            }
            .padding(.horizontal)
            content()
        }
    }
}

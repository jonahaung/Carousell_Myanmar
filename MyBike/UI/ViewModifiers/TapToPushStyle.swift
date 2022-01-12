//
//  NavigationLinkStyle.swift
//  MyBike
//
//  Created by Aung Ko Min on 28/11/21.
//

import SwiftUI

struct TapToPushStyle<Destination: View>: ViewModifier {
    
    let destination: Destination
    
    func body(content: Content) -> some View {
        return NavigationLink(destination: destination) {
            content
                .font(.sectionTitleFont(UIFont.systemFontSize + 1))
        }
        .isDetailLink(false)
        .buttonStyle(.borderless)
        
    }
}

struct TapToPushItemsListStyle: ViewModifier {
    
    let itemMenu: ItemMenu
    
    func body(content: Content) -> some View {
        return content.tapToPush(ItemListView(itemMenu))
    }
}

extension View {
    func tapToPush<Destination: View>(_ destination: Destination) -> some View {
        ModifiedContent(content: self, modifier: TapToPushStyle(destination: destination))
    }
    func tapToPushItemsList(_ itemMenu: ItemMenu) -> some View {
        ModifiedContent(content: self, modifier: TapToPushItemsListStyle(itemMenu: itemMenu))
    }
}

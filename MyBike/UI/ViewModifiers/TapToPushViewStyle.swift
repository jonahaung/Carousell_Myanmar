//
//  NavigationLinkStyle.swift
//  MyBike
//
//  Created by Aung Ko Min on 28/11/21.
//

import SwiftUI

struct TapToPushViewStyle: ViewModifier {
    
    let destination: AnyView
    
    func body(content: Content) -> some View {
        return NavigationLink(destination: destination) {
            content
        }
    }
}

struct TapToPushItemsListStyle: ViewModifier {
    
    let itemMenu: ItemMenu
    
    func body(content: Content) -> some View {
        return content.tapToPush(DoubleColGridView(itemMenu).anyView)
    }
}

extension View {
    func tapToPush(_ destination: AnyView) -> some View {
        ModifiedContent(content: self, modifier: TapToPushViewStyle(destination: destination))
    }
    func tapToPushItemsList(_ itemMenu: ItemMenu) -> some View {
        ModifiedContent(content: self, modifier: TapToPushItemsListStyle(itemMenu: itemMenu))
    }
}

extension View {
    var anyView: AnyView { AnyView(self) }
}

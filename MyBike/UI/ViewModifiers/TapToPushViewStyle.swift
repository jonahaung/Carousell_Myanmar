//
//  NavigationLinkStyle.swift
//  MyBike
//
//  Created by Aung Ko Min on 28/11/21.
//

import SwiftUI

struct TapToPushViewStyle: ViewModifier {
    
    let destination: AnyView
    let fontSize: CGFloat
    
    func body(content: Content) -> some View {
        return NavigationLink(destination: destination) {
            content
                .font(.system(size: fontSize, weight: .medium, design: .serif))
        }
    }
}

struct TapToPushItemsListStyle: ViewModifier {
    
    let itemMenu: ItemMenu
    
    func body(content: Content) -> some View {
        return content.tapToPush(DoubleCol_Scroll(itemMenu).anyView)
    }
}

extension View {
    func tapToPush(_ destination: AnyView, fontSize: CGFloat = UIFont.labelFontSize) -> some View {
        ModifiedContent(content: self, modifier: TapToPushViewStyle(destination: destination, fontSize: fontSize))
    }
    func tapToPushItemsList(_ itemMenu: ItemMenu) -> some View {
        ModifiedContent(content: self, modifier: TapToPushItemsListStyle(itemMenu: itemMenu))
    }
}

extension View {
    var anyView: AnyView { AnyView(self) }
}

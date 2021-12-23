//
//  FullScreenPresenting.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct TapToPresentViewStyle: ViewModifier {
    
    let destination: AnyView
    let isFullScreen: Bool
    
    @State private var sheetIsPresented = false
    @State private var fullScreenIsPresented = false
    
    func body(content: Content) -> some View {
        content
            .font(.Serif())
            .foregroundColor(.accentColor)
            .onTapGesture {
                Vibration.light.vibrate()
                if isFullScreen {
                    fullScreenIsPresented = true
                } else {
                    sheetIsPresented = true
                }
            }
            .fullScreenCover(isPresented: $fullScreenIsPresented) {
                destination
                    .accentColor(Color(uiColor: UIWindow.appearance().tintColor))
            }
            .sheet(isPresented: $sheetIsPresented) {
                destination
                    .accentColor(Color(uiColor: UIWindow.appearance().tintColor))
            }
    }
}

extension View {
    func tapToPresent(_ view: AnyView, _ isFullScreen: Bool) -> some View {
        ModifiedContent(content: self, modifier: TapToPresentViewStyle(destination: view, isFullScreen: isFullScreen))
    }
}

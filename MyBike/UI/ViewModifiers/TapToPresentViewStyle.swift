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
    
    @State private var isPresented = false
    
    func body(content: Content) -> some View {
        Group {
            if isFullScreen {
                content
                    .fullScreenCover(isPresented: $isPresented) {
                        destination
                    }
            }else {
                content
                    .sheet(isPresented: $isPresented) {
                        destination
                    }
            }
        }
        .foregroundColor(.accentColor)
        .onTapGesture(perform: {
            isPresented = true
        })
    }
}
extension View {
    func tapToPresent(_ view: AnyView, _ isFullScreen: Bool) -> some View {
        ModifiedContent(content: self, modifier: TapToPresentViewStyle(destination: view, isFullScreen: isFullScreen))
    }
}

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
                    .font(.Serif())
                    .foregroundColor(.accentColor)
                    .fullScreenCover(isPresented: $isPresented) {
                        destination
                    }
            }else {
                content
                    .font(.Serif())
                    .foregroundColor(.accentColor)
                    .sheet(isPresented: $isPresented) {
                        destination
                    }
            }
        }
        
        .onTapGesture(perform: {
            Vibration.rigid.vibrate()
            isPresented = true
        })
    }
}
extension View {
    func tapToPresent(_ view: AnyView, _ isFullScreen: Bool) -> some View {
        ModifiedContent(content: self, modifier: TapToPresentViewStyle(destination: view, isFullScreen: isFullScreen))
    }
}

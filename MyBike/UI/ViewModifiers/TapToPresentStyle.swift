//
//  FullScreenPresenting.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct TapToPresentStyle<Destination: View>: ViewModifier {
    
    let destination: Destination
    let isFullScreen: Bool
    
    @State private var sheetIsPresented = false
    @State private var fullScreenIsPresented = false
    
    func body(content: Content) -> some View {
        content.onTapGesture {
            if isFullScreen {
                fullScreenIsPresented = true
            } else {
                sheetIsPresented = true
            }
            Vibration.medium.vibrate()
        }
        .foregroundColor(.accentColor)
        .fullScreenCover(isPresented: $fullScreenIsPresented) {
            destination.accentColor(AppUserDefault.shared.tintColor.color)
        }
        .sheet(isPresented: $sheetIsPresented) {
            destination.accentColor(AppUserDefault.shared.tintColor.color)
        }
    }
}

typealias SomeAction = () -> Void

struct TapToPresentWithPresenter<PresenterView: View>: ViewModifier {
    
    typealias Presenter = (Binding<Bool>) -> PresenterView
    
    private let fullScreenView: Presenter
    private let onDismiss: SomeAction?
    private let onAppear: SomeAction?
    @State private var isPresented = false
    
    init(@ViewBuilder fullScreenView: @escaping Presenter, onAppear: SomeAction? = nil, onDismiss: SomeAction? = nil) {
        self.fullScreenView = fullScreenView
        self.onDismiss = onDismiss
        self.onAppear = onAppear
    }
    
    func body(content: Content) -> some View {
        Button {
            Vibration.soft.vibrate()
            isPresented = true
            onAppear?()
        } label: {
            content
        }
        .buttonStyle(.borderless)
        .fullScreenCover(isPresented: $isPresented, onDismiss: onDismiss, content: {
            fullScreenView($isPresented)
                .navigationBarItems(trailing: doneButton)
                .embeddedInNavigationView()
                .accentColor(AppUserDefault.shared.tintColor.color)
        })

    }
    
    
    private var doneButton: some View {
        Button("Done") {
            isPresented = false
        }
    }
}


extension View {
    
    func tapToPresent<Destination: View>(_ view: Destination, _ isFullScreen: Bool = false) -> some View {
        ModifiedContent(content: self, modifier: TapToPresentStyle(destination: view, isFullScreen: isFullScreen))
    }
    
    func tapToPresentWithPresentationMode<ContentView: View>(@ViewBuilder _ fullScreenView: @escaping TapToPresentWithPresenter<ContentView>.Presenter, onAppear: SomeAction? = nil, onDismiss: SomeAction? = nil) -> some View {
        let modifier = TapToPresentWithPresenter(fullScreenView: fullScreenView, onAppear: onAppear, onDismiss: onDismiss)
        return ModifiedContent(content: self, modifier: modifier)
    }
}

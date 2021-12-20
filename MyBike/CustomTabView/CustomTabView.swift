//
//  ContentView.swift
//  CustomTabBar
//
// Created by BLCKBIRDS
// Visit BLCKBIRDS.COM FOR MORE TUTORIALS

import SwiftUI

struct CustomTabView: View {
    
    @StateObject private var appBackendManager = AppBackendManager.shared
    @StateObject private var authService = AuthenticationService.shared
    @StateObject private var viewRouter = ViewRouter()
    @State private var showPopUp = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    SettingsView().opacity(viewRouter.currentPage == .settings ? 1 : 0)
                    UserProfileView().opacity(viewRouter.currentPage == .user ? 1 : 0)
                    MessagesView().opacity(viewRouter.currentPage == .messages ? 1 : 0)
                    HomeView().opacity(viewRouter.currentPage == .home ? 1 : 0)
                }
                Spacer()
                tabBar(geometry: geometry)
            }
            .edgesIgnoringSafeArea(.bottom)
            .environmentObject(authService)
            .environmentObject(appBackendManager)
        }
    }
    
    private func tabBar(geometry: GeometryProxy) -> some View {
        ZStack {
            if showPopUp {
                PlusMenu(widthAndHeight: geometry.size.width/7)
                    .offset(y: -geometry.size.height/6)
            }
            HStack {
                TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
                
                TabBarIcon(viewRouter: viewRouter, assignedPage: .messages, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "globe", tabName: "Noti")
                
                ZStack {
                    Circle()
                        .foregroundColor(.systemBackground)
                        .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                        .shadow(radius: 7)
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/7-6 , height: geometry.size.width/7-6)
                        .foregroundColor(.blue)
                        .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
                }
                .offset(y: -geometry.size.height/8/2)
                .onTapGesture {
                    Vibration.medium.vibrate()
                    withAnimation(.spring()) {
                        showPopUp.toggle()
                    }
                }
                
                TabBarIcon(viewRouter: viewRouter, assignedPage: .user, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Account")
                TabBarIcon(viewRouter: viewRouter, assignedPage: .settings, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "gear", tabName: "Settings")
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height/8)
            .background(Color.systemBackground)
            .onChange(of: viewRouter.currentPage) { newValue in
                withAnimation {
                    showPopUp = false
                }
            }
        }
    }
}

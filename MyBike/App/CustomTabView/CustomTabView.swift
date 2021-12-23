//
//  ContentView.swift
//  CustomTabBar
//
// Created by BLCKBIRDS
// Visit BLCKBIRDS.COM FOR MORE TUTORIALS

import SwiftUI

struct CustomTabView: View {
    
    private let appBackendManager = AppBackendManager.shared
    private let authService = AuthenticationService.shared
    @StateObject private var appAlertManager = AppAlertManager.shared
    @StateObject private var viewRouter = ViewRouter.shared
    @StateObject private var searchManager = SearchViewManager()
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                TabView(selection: $viewRouter.currentTab) {
                    ForEach(ViewRouter.Tab.allCases) { tab in
                        Group {
                            switch tab {
                            case .Home:
                                HomeView()
                            case .Messages:
                                MessagesView()
                            case .CurrentUserProfile:
                                CurrentUserProfileView()
                            case .Settings:
                                AppSettingsView()
                            }
                        }
                        .tag(tab)
                        .transition(.scale)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .overlay(searchOverlayView)
                .confirmationAlert($appAlertManager.alert)
                CustomTabBar(geometry: geometry)
            }
            .edgesIgnoringSafeArea(.bottom)
            .embeddedInNavigationView()
            .searchable(text: $searchManager.searchText, placement: .navigationBarDrawer, prompt: "Search")
            .environmentObject(searchManager)
            .environmentObject(viewRouter)
            .environmentObject(authService)
            .environmentObject(appBackendManager)
            .environmentObject(appAlertManager)
        }
    }
    
    private var searchOverlayView: some View {
        Group {
            if !searchManager.searchText.isEmpty {
                SearchView()
            }
        }
    }
    
    private var searchFieldPlacement: SearchFieldPlacement {
        .navigationBarDrawer(displayMode: viewRouter.homeViewMode == .doubleColumn ? .always : .automatic)
    }
}

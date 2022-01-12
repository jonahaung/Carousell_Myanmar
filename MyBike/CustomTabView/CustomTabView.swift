//
//  ContentView.swift
//  CustomTabBar
//
// Created by BLCKBIRDS
// Visit BLCKBIRDS.COM FOR MORE TUTORIALS

import SwiftUI

struct CustomTabView: View {
    
    @EnvironmentObject private var appAlertManager: AppAlertManager
    @EnvironmentObject private var appUserDefault: AppUserDefault
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $appUserDefault.currentTabViewTab) {
                ForEach(TabBarTab.allCases) { tab in
                    getView(for: tab)
                }
            }
            CustomTabBar()
                .offset(y: appAlertManager.isSearching ? 200: 0)
        }
        .overlay(NotificationBadge(notification: $appAlertManager.notification), alignment: .top)
        .confirmationAlert($appAlertManager.alert)
        .accentColor(appUserDefault.tintColor.color)
    }
    
    
    private func getView(for tab: TabBarTab) -> some View {
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
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .tag(tab)
    }
}

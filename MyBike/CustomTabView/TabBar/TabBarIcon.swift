//
//  TabBarIcon.swift
//  MyBike
//
//  Created by Aung Ko Min on 9/1/22.
//

import SwiftUI

extension CustomTabView.CustomTabBar {

    struct TabBarIcon: View {
        let assignedPage: CustomTabView.TabBarTab
        private let size = 30.00
        private var isCurrentTab: Bool { appUserDefault.currentTabViewTab == assignedPage }
        private var currentSize: CGFloat { isCurrentTab ? size * 1.5 : size }
        
        @EnvironmentObject private var appUserDefault: AppUserDefault
        
        var body: some View {
            Button {
                withAnimation(.interactiveSpring()) {
                    appUserDefault.currentTabViewTab = assignedPage
                }
            } label: {
                Image(systemName: assignedPage.iconName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(isCurrentTab ? .accentColor : .secondary)
            }
            .frame(width: currentSize, height: currentSize)
            .padding(.horizontal)
            .buttonStyle(.borderless)
        }
    }
}

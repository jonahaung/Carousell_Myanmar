//
//  TabBarIcon.swift
//  MyBike
//
//  Created by Aung Ko Min on 20/12/21.
//

import SwiftUI

struct TabBarIcon: View {
    
    let assignedPage: ViewRouter.Tab
    let width, height: CGFloat
    
    @EnvironmentObject private var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Image(systemName: assignedPage.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: viewRouter.currentTab == assignedPage ? height * 1.5 : height)
                .padding(.top, 10)
            Spacer()
        }
        .padding(.horizontal, -4)
        .foregroundColor(viewRouter.currentTab == assignedPage ? .accentColor : .tertiaryLabel)
        .onTapGesture {
            viewRouter.currentTab = assignedPage
        }
    }
}

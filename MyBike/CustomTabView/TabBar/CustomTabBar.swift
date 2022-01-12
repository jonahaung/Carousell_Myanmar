//
//  CustomTabBar.swift
//  MyBike
//
//  Created by Aung Ko Min on 9/1/22.
//

import SwiftUI

extension CustomTabView {
    
    struct CustomTabBar: View {
        
        @EnvironmentObject private var appAlertManager: AppAlertManager
        
        @State private var showPopUp = false
        
        var body: some View {
            ZStack {
                if showPopUp {
                    PlusMenu(showPopUp: $showPopUp)
                        .offset(y: -120)
                }
                HStack(alignment: .top) {
                    TabBarIcon(assignedPage: .Home)
                    TabBarIcon(assignedPage: .Messages)
                    sellButton
                    TabBarIcon(assignedPage: .CurrentUserProfile)
                    TabBarIcon(assignedPage: .Settings)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.top, 15)
                .padding(.bottom, 5)
                .background(.thickMaterial)
            }
        }
        
        private var sellButton: some View {
            let width = 55.00
            return ZStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .foregroundColor(.secondarySystemGroupedBackground)
                    .shadow(radius: 4, y: 6)
                
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .rotationEffect(Angle(degrees: showPopUp ? 45 : 0))
            }
            .frame(width: width, height: width)
            .tapToPresentWithPresentationMode { SellView(presented: $0) }
            .offset(y: -40)
        }
    }
}

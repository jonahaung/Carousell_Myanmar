//
//  CustomTabBar.swift
//  MyBike
//
//  Created by Aung Ko Min on 23/12/21.
//

import SwiftUI

struct CustomTabBar: View {
    
    let geometry: GeometryProxy
    @State private var showPopUp = false
    
    var body: some View {
        ZStack {
            if showPopUp {
                PlusMenu(showPopUp: $showPopUp, widthAndHeight: geometry.size.width/7)
                    .offset(y: -geometry.size.height/6)
            }
            
            HStack {
                let width = geometry.size.width/5
                let height = geometry.size.height/28
                
                TabBarIcon(assignedPage: .Home, width: width, height: height)
                TabBarIcon(assignedPage: .Messages, width: width, height: height)
                
                sellButton(for: geometry)
                
                TabBarIcon(assignedPage: .CurrentUserProfile, width: width, height: height)
                TabBarIcon(assignedPage: .Settings, width: width, height: height)
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height/8)
            .background(.regularMaterial)
        }
    }
    
    private func sellButton(for geometry: GeometryProxy) -> some View {
        ZStack {
            Image(systemName: "circle.fill")
                .resizable()
                .foregroundColor(.systemBackground)
                .frame(width: 60, height: 60)
                .shadow(color: .gray.opacity(0.7), radius: 4, y: 6)
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 54, height: 54)
                .foregroundColor(.accentColor)
                .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
                .tapToPush(SellView().navigationBarBackButtonHidden(true).anyView)
        }
        .offset(y: -geometry.size.height/8/2)
        
    }
}

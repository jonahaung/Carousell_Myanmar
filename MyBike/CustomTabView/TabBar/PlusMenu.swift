//
//  PlusMenu.swift
//  MyBike
//
//  Created by Aung Ko Min on 9/1/22.
//

import SwiftUI

extension CustomTabView.CustomTabBar {
    
    struct PlusMenu: View {
        
        @Binding var showPopUp: Bool
        private let widthAndHeight: CGFloat = 60
        
        var body: some View {
            HStack(spacing: 50) {
                ZStack {
                    Circle()
                        .foregroundColor(.accentColor)
                        .frame(width: widthAndHeight, height: widthAndHeight)
                        .shadow(radius: 3)
                    Image(systemName: "applelogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(12)
                        .frame(width: widthAndHeight, height: widthAndHeight)
                        .foregroundColor(.systemBackground)
                }
                ZStack {
                    Circle()
                        .foregroundColor(.accentColor)
                        .frame(width: widthAndHeight, height: widthAndHeight)
                        .shadow(radius: 3)
                    Image(systemName: "swift")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(12)
                        .frame(width: widthAndHeight, height: widthAndHeight)
                        .foregroundColor(.systemBackground)
                }
                .onTapGesture {
                    withAnimation {
                        showPopUp = false
                    }
                }
            }
            .transition(.scale)
        }
    }
}

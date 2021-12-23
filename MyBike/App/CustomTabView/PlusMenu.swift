//
//  PlusMenu.swift
//  MyBike
//
//  Created by Aung Ko Min on 20/12/21.
//

import SwiftUI

struct PlusMenu: View {
    
    var showPopUp: Binding<Bool>
    
    let widthAndHeight: CGFloat
    
    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                Circle()
                    .foregroundColor(.systemBackground)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .shadow(radius: 3)
                Image(systemName: "record.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(.blue)
            }
            ZStack {
                Circle()
                    .foregroundColor(.systemBackground)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .shadow(radius: 3)
                Image(systemName: "folder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(.blue)
            }.onTapGesture {
                Vibration.medium.vibrate()
                withAnimation(.interactiveSpring()) {
                    showPopUp.wrappedValue = false
                }
            }
        }
        .transition(.scale)
    }
}

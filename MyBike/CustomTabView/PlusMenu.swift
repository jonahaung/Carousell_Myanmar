//
//  PlusMenu.swift
//  MyBike
//
//  Created by Aung Ko Min on 20/12/21.
//

import SwiftUI

struct PlusMenu: View {
    
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
            .tapToPush(SellView().anyView)
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
            }
            .tapToPresent(SellView().anyView, true)
        }
        .transition(.scale)
    }
}

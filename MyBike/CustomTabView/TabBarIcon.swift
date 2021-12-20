//
//  TabBarIcon.swift
//  MyBike
//
//  Created by Aung Ko Min on 20/12/21.
//

import SwiftUI

struct TabBarIcon: View {
    
    @StateObject var viewRouter: ViewRouter
    let assignedPage: ViewRouter.Page
    
    let width, height: CGFloat
    let systemIconName, tabName: String
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }
        .padding(.horizontal, -4)
        .onTapGesture {
            ToneManager.vibrate(vibration: .light)
            withAnimation {
                viewRouter.currentPage = assignedPage
            }
        }
        .foregroundColor(viewRouter.currentPage == assignedPage ? .accentColor : .tertiaryLabel)
    }
}

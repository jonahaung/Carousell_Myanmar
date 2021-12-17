//
//  SellButtonView.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import SwiftUI

struct SellButtonView: View {
    
    var body: some View {
        Image(systemName: "plus")
            .resizable()
            .frame(width: 25, height: 25)
            .foregroundColor(.white)
            .zIndex(3)
            .padding(12)
            .background(Circle().fill(Color.accentColor))
            .padding()
            .tapToPush(SellView().anyView)
    }
}

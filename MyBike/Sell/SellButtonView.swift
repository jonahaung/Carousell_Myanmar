//
//  SellButtonView.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import SwiftUI

struct SellButtonView: View {
    
    var body: some View {
        Image(systemName: "plus.circle.fill")
            .resizable()
            .frame(width: 44, height: 44)
            .background(Circle().fill(Color.white))
            .zIndex(5)
            .padding()
            .tapToPush(SellView().anyView)
    }
}

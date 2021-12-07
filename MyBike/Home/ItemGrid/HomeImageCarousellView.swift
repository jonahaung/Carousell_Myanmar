//
//  HomeImageCarousellView.swift
//  MyBike
//
//  Created by Aung Ko Min on 6/12/21.
//

import SwiftUI

struct HomeImageCarousellView: View {
    
    var body: some View {
        VStack {
            VStack {
                Text("Don't see listings that interest you?")
                    .font(.system(size: 20, weight: .semibold))
                Text("Tell us what categories you like to help us find relevant content for you.")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            .multilineTextAlignment(.center)
            .padding()
            
        }
        .insetGroupSectionStyle(20)
    }
}

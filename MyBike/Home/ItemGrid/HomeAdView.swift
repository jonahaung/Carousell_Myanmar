//
//  HomeAdView.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/12/21.
//

import SwiftUI

struct HomeAdView: View {
    
    var body: some View {
        VStack {
            VStack {
                Text("Don't see listings that interest you?")
                    .font(.system(size: 20, weight: .semibold))
                Text("Tell us what categories you like to help us find relevant content for you.")
                    .foregroundColor(.secondary)
                Text("Get Started")
                    .foregroundColor(.white)
                    .padding(8)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    .tapToPresent(List { CategoryList() }.anyView, false)

            }
            .multilineTextAlignment(.center)
            .padding()
            
        }
        .insetGroupSectionStyle(20)
        .background(Color.steam_yellow)
    }
}

struct HomeAdView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAdView()
    }
}

//
//  HomeAdView.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/12/21.
//

import SwiftUI

struct HomeAdsView: View {
    
    var body: some View {
        SectionWithTitleView("Ads") {
            VStack {
                Text("Don't see listings that interest you?")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.primary)
                Text("Tell us what categories you like to help us find relevant content for you.")
                    .foregroundColor(.secondary)
                Text("Get Started")
                    .tapToPresent(CategoryPickerView(category: .constant(.none)).embeddedInNavigationViewWithCancelButton(), false)
            }
            .multilineTextAlignment(.center)
            .padding()
            .insetGroupSectionStyle(padding: 5)
        }
    }
}

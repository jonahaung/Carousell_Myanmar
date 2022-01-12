//
//  SectionWithTitleView.swift
//  MyBike
//
//  Created by Aung Ko Min on 12/1/22.
//

import SwiftUI

struct SectionWithTitleView<Content: View>: View {
    
    private let content: () -> Content
    private let title: String
    
    init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.title = title
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(title)
                    .font(.sectionTitleFont(20))
                Spacer()
            }
            .padding(.horizontal)
            content()
        }
    }
}

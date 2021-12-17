//
//  InsetGroupSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct InsetGroupSectionStyle: ViewModifier {
    
    let padding: CGFloat
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: padding) {
            VStack(alignment: .leading, spacing: 0) {
                content
            }
//            .cornerRadius(10)
            .padding(padding)
        }
        .background(Color.secondarySystemGroupedBackground.cornerRadius(12))
        .padding(10)
    }
    
}
extension View {
    func insetGroupSectionStyle(_ padding: CGFloat = 12) -> some View {
        return ModifiedContent(content: self, modifier: InsetGroupSectionStyle(padding: padding))
    }
}

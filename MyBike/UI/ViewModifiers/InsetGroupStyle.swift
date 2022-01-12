//
//  InsetGroupSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct InsetGroupStyle: ViewModifier {
    
    
    let sectionPadding: CGFloat
    let innerPadding: CGFloat
    let rowSpacing: CGFloat
    let cornorRadius: CGFloat
    
    func body(content: Content) -> some View {
        VStack(spacing: rowSpacing) {
            content
        }
        .padding(innerPadding)
        .background(Color.secondarySystemGroupedBackground.cornerRadius(cornorRadius))
        .padding(sectionPadding)
    }
    
}
extension View {
    func insetGroupSectionStyle(padding: CGFloat = 10, innerPadding: CGFloat = 15, rowSpacing: CGFloat = 0, cornorRadius: CGFloat = 9) -> some View {
        return ModifiedContent(content: self, modifier: InsetGroupStyle(sectionPadding: padding, innerPadding: innerPadding, rowSpacing: rowSpacing, cornorRadius: cornorRadius))
    }
}

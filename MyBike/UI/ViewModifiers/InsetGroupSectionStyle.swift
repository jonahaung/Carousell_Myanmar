//
//  InsetGroupSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct InsetGroupSectionStyle: ViewModifier {
    
    let sectionPadding: CGFloat
    let innerPadding: CGFloat
    let rowSpacing: CGFloat
    
    func body(content: Content) -> some View {
        VStack(spacing: rowSpacing) {
            content
        }
        .padding(innerPadding)
        .background(Color.secondarySystemGroupedBackground.cornerRadius(9))
        .padding(sectionPadding)
    }
    
}
extension View {
    func insetGroupSectionStyle(padding: CGFloat = 10, innerPadding: CGFloat = 10, rowSpacing: CGFloat = 0) -> some View {
        return ModifiedContent(content: self, modifier: InsetGroupSectionStyle(sectionPadding: padding, innerPadding: innerPadding, rowSpacing: rowSpacing))
    }
}

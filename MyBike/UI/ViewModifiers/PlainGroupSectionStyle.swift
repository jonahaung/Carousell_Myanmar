//
//  PlainGroupSectionStyle.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/12/21.
//

import SwiftUI

struct PlainGroupSectionStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                content
            }
            .padding(.vertical)
        }
//        .padding(3)
        .background(Color.secondarySystemGroupedBackground)
    }
}
extension View {
    func plainGroupSectionStyle() -> some View {
        return ModifiedContent(content: self, modifier: PlainGroupSectionStyle())
    }
}

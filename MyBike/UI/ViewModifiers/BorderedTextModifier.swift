//
//  BorderedTextModifier.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/11/21.
//

import SwiftUI

struct BorderedTextModifier: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(color, lineWidth: 2)
                    .background(.clear)
                    .cornerRadius(6)
            )
    }
}

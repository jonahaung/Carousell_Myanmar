//
//  FormSubmitButtonStyle.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct FormSubmitButtonStyle: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
                .foregroundColor(.white)
            Spacer()
        }
        .padding(7)
        .background(RoundedRectangle(cornerRadius: 5).fill(backgroundColor))
    }
}

extension Text {
    func formSubmitButtonStyle(_ backgroundColor: Color = .accentColor) -> some View {
        return ModifiedContent(content: self, modifier: FormSubmitButtonStyle(backgroundColor: backgroundColor))
    }
}

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
        content
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.vertical)
            .background(backgroundColor.cornerRadius(5))
    }
}

extension Text {
    func formSubmitButtonStyle(_ backgroundColor: Color = .accentColor) -> some View {
        return ModifiedContent(content: self, modifier: FormSubmitButtonStyle(backgroundColor: backgroundColor))
    }
}

//
//  TextStyle.swift
//  MyBike
//
//  Created by Aung Ko Min on 28/11/21.
//

import SwiftUI

struct TextStyle: ViewModifier {
    
    enum Style {
        
        case title_headline, title_footnote, title_regular, title_title, link_regular, link_small
        
        var font: Font {
            switch self {
            case .title_regular:
                return .FjallaOne(UIFontMetrics.default.scaledValue(for: 16))
            case .title_headline:
                return .FjallaOne(UIFontMetrics.default.scaledValue(for: 17))
            case .title_footnote:
                return .FjallaOne(UIFontMetrics.default.scaledValue(for: 13))
            case .title_title:
                return .FjallaOne(UIFontMetrics.default.scaledValue(for: 21))
            case .link_regular:
                return .system(size: UIFont.labelFontSize, weight: .medium, design: .serif)
            case .link_small:
                return .system(size: UIFont.systemFontSize, weight: .regular, design: .serif)
            
            }
        }

    }
    
    let style: Style
    
    func body(content: Content) -> some View {
        content
            .font(style.font)
    }
}

extension View {
    func textStyle(style: TextStyle.Style) -> some View {
        return ModifiedContent(content: self, modifier: TextStyle(style: style))
    }
}



//
//  Font.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 23/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import Foundation
import SwiftUI

extension Font {
    
    static func navigationTitleFont(_ size: CGFloat = UIFont.labelFontSize) -> Font {
        return Font.custom("KaushanScript-Regular", size: UIFontMetrics.default.scaledValue(for: size))
    }
    static func sectionTitleFont(_ size: CGFloat = UIFont.systemFontSize) -> Font {
        return Font.custom("ReggaeOne-Regular", size: UIFontMetrics.default.scaledValue(for: size))
    }
    
    static func FHACondFrenchNC(_ size: CGFloat = UIFont.labelFontSize) -> Font {
        return Font.custom("FHA Condensed French NC", size: UIFontMetrics.default.scaledValue(for: size))
    }
    
    static func AmericanCaptain(_ size: CGFloat = UIFont.labelFontSize) -> Font {
        return Font.custom("American Captain", size: UIFontMetrics.default.scaledValue(for: size))
    }
    
    static func FjallaOne(_ size: CGFloat = UIFont.systemFontSize) -> Font {
        return Font.custom("FjallaOne-Regular", size: UIFontMetrics.default.scaledValue(for: size))
    }
    
    static func Righteous(_ size: CGFloat = UIFont.labelFontSize) -> Font {
        return Font.custom("Righteous-Regular", size: UIFontMetrics.default.scaledValue(for: size))
    }
}

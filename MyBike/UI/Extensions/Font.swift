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
    static func FHACondFrenchNC(_ size: CGFloat = UIFont.labelFontSize) -> Font {
        return Font.custom("FHA Condensed French NC", size: size)
    }
    
    static func AmericanCaptain(_ size: CGFloat = UIFont.labelFontSize) -> Font {
        return Font.custom("American Captain", size: size)
    }
    
    static func FjallaOne(_ size: CGFloat = UIFont.labelFontSize) -> Font {
        return Font.custom("FjallaOne-Regular", size: size)
    }
    
    static func Serif(_ size: CGFloat = UIFont.labelFontSize) -> Font {
        return Font.system(size: UIFont.labelFontSize, design: .serif)
    }
    
       
}

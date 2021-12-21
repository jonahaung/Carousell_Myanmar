//
//  ColorScheme.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 13/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    public static var tertiaryLabel: Color {
        Color(uiColor: .tertiaryLabel)
    }
    public static var quaternaryLabel: Color {
        Color(uiColor: .quaternaryLabel)
    }
    public static var systemBackground: Color {
        Color(uiColor: .systemBackground)
    }
    public static var tertiarySystemBackground: Color {
        Color(uiColor: .tertiarySystemBackground)
    }
    public static var groupedTableViewBackground: Color {
        Color(uiColor: .groupTableViewBackground)
        
    }
    public static var secondarySystemGroupedBackground: Color {
        Color(uiColor: .secondarySystemGroupedBackground)
    }
    public static var tertiarySystemGroupedBackground: Color {
        Color(uiColor: .tertiarySystemGroupedBackground)
    }
    public static var secondarySystemBackground: Color {
        Color(uiColor: .secondarySystemBackground)
    }
    public static var steam_white: Color {
        Color("steam_white", bundle: nil)
    }
    
    public static var steam_gold: Color {
        Color("steam_gold", bundle: nil)
    }
    
    public static var steam_rust: Color {
        Color("steam_rust", bundle: nil)
    } 
    public static var steam_rust2: Color {
        Color("steam_rust2", bundle: nil)
    }
    
    public static var steam_bronze: Color {
        Color("steam_bronze", bundle: nil)
    }
    
    public static var steam_brown: Color {
        Color("steam_brown", bundle: nil)
    }
    
    public static var steam_yellow: Color {
        Color("steam_yellow", bundle: nil)
    }
    
    public static var steam_blue: Color {
        Color("steam_blue", bundle: nil)
    }
    
    public static var steam_bordeaux: Color {
        Color("steam_bordeaux", bundle: nil)
    }
    
    public static var steam_green: Color {
        Color("steam_green", bundle: nil)
    }
    
    public static var steam_background: Color {
        Color("steam_background", bundle: nil)
    }
    
    public static var randomColor: Color {
        Color(uiColor: UIColor.systemColors.randomElement()!)
    }
}



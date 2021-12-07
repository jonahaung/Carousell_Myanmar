//
//  PosterStyle.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 06/07/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct PosterStyle: ViewModifier {
    
    enum Size {
        
        case tinyPersonImage, small, medium, big
        case custom(CGFloat)
        
        static let screenWidth = UIScreen.main.bounds.size.width
        
        var width: CGFloat {
            switch self {
            case .tinyPersonImage: return 20
            case .small: return 60
            case .medium: return 140
            case .big: return PosterStyle.Size.screenWidth
                case .custom(let x): return x }
        }
        
        var height: CGFloat {
            switch self {
            case .tinyPersonImage: return 20
            case .small: return 60
            case .medium: return 140
            case .big: return PosterStyle.Size.screenWidth
            case .custom(let x): return x
            }
        }
    }
    
    let size: Size
    
    func body(content: Content) -> some View {
        content
            .frame(width: size.width, height: size.height)
    }
}

extension View {
    func posterStyle(size: PosterStyle.Size) -> some View {
        return ModifiedContent(content: self, modifier: PosterStyle(size: size))
    }
}

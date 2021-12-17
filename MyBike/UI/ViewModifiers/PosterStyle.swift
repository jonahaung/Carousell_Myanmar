//
//  PosterStyle.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 06/07/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct PosterStyle: ViewModifier {
    
    static let aspectRatio = 1.4
    
    enum Size {
        
        case tinyPersonImage, small, medium, big
        case custom(CGFloat)
        
        var width: CGFloat {
            switch self {
            case .tinyPersonImage: return 20
            case .small: return 80
            case .medium: return 120
            case .big: return 200
            case .custom(let x): return x }
        }
        
        var height: CGFloat {
            return width * PosterStyle.aspectRatio
        }
        
        var cgSize: CGSize {
            CGSize(width: width, height: height)
        }
    }
    
    let posterSize: Size
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: posterSize.width, maxHeight: posterSize.height)
    }
}

extension View {
    func posterStyle(posterSize: PosterStyle.Size) -> some View {
        return ModifiedContent(content: self, modifier: PosterStyle(posterSize: posterSize))
    }
}

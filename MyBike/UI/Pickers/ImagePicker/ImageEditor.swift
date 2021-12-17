//
//  ImageEditor.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import UIKit

struct ImageEditor {
    
    static func resize(_ image: UIImage, to width: CGFloat) -> UIImage {
        
        let oldWidth = image.size.width
        let scaleFactor = width / oldWidth
        
        let newHeight = image.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        let newSize = CGSize(width: newWidth, height: newHeight)

        return UIGraphicsImageRenderer(size: newSize).image { _ in
            image.draw(in: .init(origin: .zero, size: newSize))
        }
//        let parentSize = CGSize(width: newSize.width, height: newSize.width * PosterStyle.aspectRatio)
//        let result = UIGraphicsImageRenderer(size: parentSize).image { _ in
//            image.draw(in: CGRect(parentSize: parentSize, size: newSize))
//        }
//        let color = result.getColors()?.background ?? .black
//        return result.withBackground(color: color, opaque: false)
        
    }
    
    static func cropImageToSquare(image: UIImage) -> UIImage? {
        var imageHeight = image.size.height
        var imageWidth = image.size.width
        
        if imageHeight > imageWidth {
            imageHeight = imageWidth
        }
        else {
            imageWidth = imageHeight
        }
        
        let size = CGSize(width: imageWidth, height: imageHeight)
        
        let refWidth : CGFloat = CGFloat(image.cgImage!.width)  * PosterStyle.aspectRatio
        let refHeight : CGFloat = CGFloat(image.cgImage!.height)
        
        let x = (refWidth - size.width) / 2
        let y = (refHeight - size.height) / 2
        
        let cropRect = CGRect(x: x, y: y, width: size.height, height: size.width)
        if let imageRef = image.cgImage!.cropping(to: cropRect) {
            return UIImage(cgImage: imageRef, scale: 0, orientation: image.imageOrientation)
        }
        
        return nil
    }
    
}

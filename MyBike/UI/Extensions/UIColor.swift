//
//  UIColor.swift
//  MyBike
//
//  Created by Aung Ko Min on 10/12/21.
//

import UIKit

extension UIColor {
    
    static let systemColors = [UIColor.black, .systemGray, .systemBlue, .systemYellow, .systemGreen, .systemOrange, .systemPurple, .systemTeal, .systemPink, .systemFill, .systemMint, .systemIndigo, .systemRed]
    static var random: UIColor { return systemColors.randomElement()! }
    
    func getImage(with size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

//
//  Foundation.swift
//  MyBike
//
//  Created by Aung Ko Min on 10/12/21.
//

import UIKit

extension CGRect {
    init(parentSize: CGSize, size: CGSize){
        let parentRect = CGRect(origin: .zero, size: parentSize)
        let center = CGPoint(x: parentRect.midX, y: parentRect.midY)
        self.init(x: center.x - size.width / 2, y: center.y - size.height / 2, width: size.width, height: size.height)
    }
}

//
//  Protocols.swift
//  MyBike
//
//  Created by Aung Ko Min on 26/12/21.
//

import Foundation

protocol StringRepresentable {
    var stringValue: String { get }
}
extension StringRepresentable {
    var stringValue: String { "\(self)" }
}


protocol UIElementRepresentable: Identifiable, StringRepresentable {
    
    var id: String { get }
    
    func uiElements() -> Item.UIElements
}

extension UIElementRepresentable {
    var id: String { stringValue }
    func uiElements() -> Item.UIElements { .mock }
}



//
//  Date.swift
//  MyBike
//
//  Created by Aung Ko Min on 25/11/21.
//

import Foundation

extension Date {
    
    private static let relativeDateFormatter = RelativeDateTimeFormatter()
    
    var relativeString: String {
        Date.relativeDateFormatter.localizedString(for: self, relativeTo: Date())
    }
}

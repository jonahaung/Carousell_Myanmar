//
//  Alert.swift
//  MyBike
//
//  Created by Aung Ko Min on 10/12/21.
//

import SwiftUI

extension Alert: Identifiable {
    
    public var id: String {
        return UUID().uuidString
    }
    
}


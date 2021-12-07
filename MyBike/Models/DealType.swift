//
//  DealType.swift
//  MyBike
//
//  Created by Aung Ko Min on 25/11/21.
//

import Foundation

enum DealType: Codable, CaseIterable, Identifiable {
    var id: DealType { return self }
    case Sell, Buy, Exchange
    
    var description: String {
        return "\(self)"
    }
}

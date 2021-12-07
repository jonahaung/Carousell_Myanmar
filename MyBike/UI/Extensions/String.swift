//
//  String.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/12/21.
//

import Foundation

extension String {
    var trimmed: String { self.trimmingCharacters(in: .whitespacesAndNewlines) }
    
    var keywords: [String] {
        return KeywordGenerator(text: self).execute()
    }
}

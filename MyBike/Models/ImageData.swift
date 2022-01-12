//
//  ImageData.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/11/21.
//

import Foundation

struct ImageData: Codable, Identifiable, Hashable {
    
    var id: String {
        file_path
    }
    let file_path: String
}

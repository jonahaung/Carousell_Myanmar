//
//  Message.swift
//  MyBike
//
//  Created by Aung Ko Min on 7/12/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Codable {
    
    @DocumentID var id: String?
    let text: String
    
    init(id: String, text: String) {
        self.id = id
        self.text = text
    }
}

//
//  Conversation.swift
//  MyBike
//
//  Created by Aung Ko Min on 7/12/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Conversation: Codable {
    
    @DocumentID var id: String?
    var conversationReference: DocumentReference
}

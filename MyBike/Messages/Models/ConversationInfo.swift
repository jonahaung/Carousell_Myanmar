//
//  ConversationInfo.swift
//  MyBike
//
//  Created by Aung Ko Min on 7/12/21.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ConversationInfo: Codable {
    
    @DocumentID var id: String?
    
    var lastMsgRef: DocumentReference
    
    init(conversationId: String, _msgId: String) {
        id = conversationId
        lastMsgRef = Firestore.firestore().collection("conversations").document(conversationId)
    }
}

extension ConversationInfo {
    
    static func conversationId(for personId: String?) -> String? {
        guard let personId = personId, let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        return uid > personId ? uid + personId : personId + uid
    }
}

//
//  MessageRepository.swift
//  MyBike
//
//  Created by Aung Ko Min on 7/12/21.
//

import Foundation
import FirebaseFirestore
import Combine
import FirebaseFirestoreSwift

class MessageRepository: ObservableObject {
    
    static let shared = MessageRepository()
    private let path: String = "conversations"
    private let store = Firestore.firestore()
    
    
    func add(_ msg: Message, conversationId: String, completion: @escaping ()-> Void) {
        do {
            _ = try store.collection("conversations").document().collection(conversationId).addDocument(from: msg, completion: { error in
                self.store.collection("conversations").document().collection(conversationId).getDocuments { snap, error in
//                    print(snap?.documents)
                    completion()
                }
                
            })
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription).")
        }
    }
    func add(_ conversationInfo: ConversationInfo, personId: String, completion: @escaping ()-> Void) {
        do {
            _ = try store.collection("conversationInfos").document().collection(personId).addDocument(from: conversationInfo, completion: { error in
                completion()
            })
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription).")
        }
    }
}

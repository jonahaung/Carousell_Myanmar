//
//  ItemSellerSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemSellerSection: View {
    
    @StateObject var itemViewModel: ItemViewModel
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    PersonImageView(itemViewModel.item.seller.photoUrl, .medium)
                    VStack {
                        Text(itemViewModel.item.seller.userName)
                        PopularityBadge(score: Int.random(in: 1..<99))
                    }
                    Spacer()
                }
                Divider()
                
                Button {
                    
                    if let personId = itemViewModel.item.seller.id, let conversationId = ConversationInfo.conversationId(for: personId) {
                        let msgId = UUID().uuidString
                        let info = ConversationInfo(conversationId: conversationId, _msgId: msgId)
                        let message = Message(id: msgId, text: "Hello")
//                        MessageRepository.shared.add(message, conversationId: conversationId) {
//                            MessageRepository.shared.add(info, personId: personId) {
//                                print("DONE")
//                            }
//                        }
                    
                    }
                } label: {
                    Text("Message").formSubmitButtonStyle(.blue)
                }

            }
        }.insetGroupSectionStyle()
    }
}

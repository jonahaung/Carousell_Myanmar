//
//  ItemBuySection.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemBuySection: View {
    
    @StateObject var itemViewModel: ItemViewModel
    
    var body: some View {
        HStack {
            getButton
            chatButton
        }
        .padding(.vertical)
    }
    
    private var getButton: some View {
        Button {
            
        } label: {
            Text("Get this item")
                .formSubmitButtonStyle(.pink)
                .padding(.horizontal)
        }
    }
    private var chatButton: some View {
        Button {
            
        } label: {
            Text("Start Chat")
                .formSubmitButtonStyle(.mint)
                .padding(.horizontal)
        }
    }
}

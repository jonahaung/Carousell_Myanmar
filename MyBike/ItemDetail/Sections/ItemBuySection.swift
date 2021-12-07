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
        Group {
            Button {
                
            } label: {
                Text("Get this item")
                    .formSubmitButtonStyle(.pink)
            }
        }.insetGroupSectionStyle()
    }
}

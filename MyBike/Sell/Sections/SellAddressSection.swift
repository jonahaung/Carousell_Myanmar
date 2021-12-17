//
//  SellAddressSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 6/12/21.
//

import SwiftUI

struct SellAddressSection: View {
    
    @Binding var address: Item.Address

    var body: some View {
        Group {
            Text(address.township)
            Text(address.state)
                .italic()
                .foregroundStyle(.secondary)
        }
    }
}

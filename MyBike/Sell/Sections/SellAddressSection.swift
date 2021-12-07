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
        Section {
            HStack {
                Text(address.township)
                Spacer()
                Text(address.state)
                    .foregroundColor(.secondary)
            }
            .tapToPush(RegionPicker(selected: address, onPick: { address in
                self.address = address
            }).anyView)
        }
    }
}

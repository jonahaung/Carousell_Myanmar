//
//  BikeContextMenu.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/11/21.
//

import SwiftUI

struct ItemContextMenu: View {
    
    @ObservedObject var itemViewModel: ItemViewModel

    var body: some View {
        ItemFavouritesLabel(itemViewModel)
        Button(action: {
            itemViewModel.delete()
        }) {
            HStack {
                Text("Delete")
                Image(systemName: "trash.fill")
                    .imageScale(.small)
                    
            }
        }
    }
}

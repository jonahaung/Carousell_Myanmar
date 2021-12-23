//
//  HomeImageCarousellView.swift
//  MyBike
//
//  Created by Aung Ko Min on 6/12/21.
//

import SwiftUI

struct Home_Grid_Section_ImageCarousell: View {
    
    @StateObject var itemViewModel: ItemViewModel
    
    var body: some View {
        SingleAxisGeometryReader { width in
            ImageCarouselView(itemViewModel: itemViewModel)
                .padding(3)
                .frame(height: width)
                .background(Color.secondarySystemGroupedBackground)
        }
    }
}

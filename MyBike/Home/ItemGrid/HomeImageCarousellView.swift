//
//  HomeImageCarousellView.swift
//  MyBike
//
//  Created by Aung Ko Min on 6/12/21.
//

import SwiftUI

struct HomeImageCarousellView: View {
    
    @ObservedObject var itemViewModel: ItemViewModel
    let geo: GeometryProxy
    var body: some View {
        ImageCarouselView(itemViewModel: itemViewModel)
            .padding(3)
            .frame(height: geo.frame(in: .local).width)
            .background(Color.secondarySystemGroupedBackground)
    }
}

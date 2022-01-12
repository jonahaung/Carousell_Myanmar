//
//  HomeImageCarousellView.swift
//  MyBike
//
//  Created by Aung Ko Min on 6/12/21.
//

import SwiftUI

struct Home_Grid_Section_ImageCarousell: View {
    
    let geometry: GeometryProxy
    @StateObject private var manager = Home_Grid_Section_ImageCarousellManager()
    
    var body: some View {
        let width = min(geometry.size.width, geometry.size.height)
        ImageCarouselView(manager.imageDatas)
            .padding(3)
            .background(Color.secondarySystemGroupedBackground)
            .frame(width: width, height: width)
            .task {
                guard manager.imageDatas.isEmpty else { return }
                manager.getImages()
            }
    }
}

//
//  ItemImagesRow.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemImagesSection: View {
    
    @StateObject var itemViewModel: ItemViewModel
    let geo: GeometryProxy
    
    var body: some View {
        ImageCarouselView(itemViewModel: itemViewModel)
            .frame(height: geo.size.width * PosterStyle.aspectRatio)
            .insetGroupSectionStyle(0)
    }
}

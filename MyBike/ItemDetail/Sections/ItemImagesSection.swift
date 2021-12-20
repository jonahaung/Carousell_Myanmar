//
//  ItemImagesRow.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemImagesSection: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        ImageCarouselView(itemViewModel: itemViewModel)
            .insetGroupSectionStyle(0)
            .aspectRatio(1/PosterStyle.aspectRatio, contentMode: .fit)
    }
}

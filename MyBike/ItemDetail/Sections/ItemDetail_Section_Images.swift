//
//  ItemImagesRow.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemDetail_Section_Images: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        ImageCarouselView(itemViewModel: itemViewModel)
            .insetGroupSectionStyle()
            .aspectRatio(1/PosterStyle.aspectRatio, contentMode: .fit)
    }
}

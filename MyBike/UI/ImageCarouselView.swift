//
//  ImageCarouselView.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ImageCarouselView: View {
    
    @State private var imageDatas = [ImageData]()
    @State private var selectedData: ImageData
    
    init(_ imageDatas: [ImageData], _ selectedUrl: String) {
        self.imageDatas = imageDatas
        self.selectedData = ImageData(file_path: selectedUrl)
    }
    
    init(itemViewModel: ItemViewModel) {
        let imageDatas = itemViewModel.item.images.urls.map{ ImageData(file_path: $0)}
        self.init(imageDatas, itemViewModel.item.images.urls.first ?? "")
    }
    var body: some View {
        TabView(selection: $selectedData) {
            ForEach(imageDatas) { data in
                ItemImageView(data.file_path, .big)
                    .tag(data)
                    .tapToPresent(FullScreenImagesCarouselView(imageDatas: imageDatas, selectedData: selectedData).anyView, true)
                    
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .posterStyle(size: .big)
    }
}


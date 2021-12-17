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
    @State private var showFullScreen = false
    
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
            ForEach(imageDatas) { imageData in
                Group {
                    GeometryReader { geo in
                        let width = geo.size.width
                        let size = PosterStyle.Size.custom(width)
                        ItemImageView(imageData.file_path, size).onTapGesture {
                            showFullScreen = true
                        }
                    }
                }.tag(imageData)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .automatic))
        .fullScreenCover(isPresented: $showFullScreen) {
            FullScreenImagesCarouselView(imageDatas: imageDatas, selectedData: $selectedData)
        }
    }
}

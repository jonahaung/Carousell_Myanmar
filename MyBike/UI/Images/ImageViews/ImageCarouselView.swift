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
    
    init(_ imageDatas: [ImageData], _ selectedUrl: String? = nil) {
        self.imageDatas = imageDatas
        guard let selectedUrl = selectedUrl else {
            selectedData = imageDatas.first!
            return
        }
        self.selectedData = ImageData(file_path: selectedUrl)
    }
    
    init(itemViewModel: ItemViewModel) {
        let imageDatas = itemViewModel.item.images.urls.map{ ImageData(file_path: $0)}
        self.init(imageDatas, itemViewModel.item.images.urls.first ?? "")
    }
    
    var body: some View {
        TabView(selection: $selectedData) {
            ForEach(imageDatas, id: \.self) { imageData in
                ItemImageView(imageData.file_path, .big).onTapGesture {
                    showFullScreen = true
                }
            }
        }
        .tabViewStyle(.page)
        .fullScreenCover(isPresented: $showFullScreen) {
            FullScreenImagesCarouselView(imageDatas: imageDatas, selectedData: $selectedData)
        }
    }
}

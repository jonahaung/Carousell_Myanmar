//
//  BikeListImage.swift
//  MyBike
//
//  Created by Aung Ko Min on 11/11/21.
//

import SwiftUI


struct ItemImageView: View {

    @ObservedObject private var imageLoader: ImageLoader
   
    init(_ urlString: String, _ posterSize: PosterStyle.Size) {
        imageLoader = ImageLoaderCache.shared.loaderFor(path: urlString, size: posterSize)
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
        } else {
            ZStack {
                Image(uiImage: ImageLoader.emptyImage)
                    .resizable()
                ProgressView()
            }
        }
    }
}

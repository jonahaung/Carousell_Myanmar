//
//  BikeListImage.swift
//  MyBike
//
//  Created by Aung Ko Min on 11/11/21.
//

import SwiftUI


struct ItemImageView: View {
    
    @ObservedObject private var imageLoader: ImageLoader
    private let posterSize: PosterStyle.Size
   
    init(_ urlString: String, _ posterSize: PosterStyle.Size) {
        self.posterSize = posterSize
        imageLoader = ImageLoaderCache.shared.loaderFor(path: urlString, size: posterSize)
    }
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .frame(width: posterSize.width, height: posterSize.height)
                    
            }
        }
//        .posterStyle(posterSize: posterSize)
    }
}

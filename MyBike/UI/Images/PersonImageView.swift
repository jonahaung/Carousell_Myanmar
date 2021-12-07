//
//  PersonImage.swift
//  MyBike
//
//  Created by Aung Ko Min on 11/11/21.
//

import SwiftUI

struct PersonImageView: View {
    
    @ObservedObject private var imageLoader: ImageLoader
    private let posterSize: PosterStyle.Size
    
    init(_ urlString: String, _ posterSize: PosterStyle.Size) {
        self.posterSize = posterSize
        imageLoader = ImageLoaderCache.shared.loaderFor(path: urlString, size: posterSize)
    }
    
    var body: some View {
        Group {
            if let uiImage = imageLoader.image {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                ProgressView()
            }
        }
        .posterStyle(size: posterSize)
        .clipShape(Circle())
    }
}

//
//  ImageData.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 09/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

class ImageLoaderCache {
    
    static let shared = ImageLoaderCache()
    
    var loaders: NSCache<NSString, ImageLoader> = NSCache()
    
    func loaderFor(path: String, size: PosterStyle.Size) -> ImageLoader {
        let key = NSString(string: path + "\(size)")
        if let loader = loaders.object(forKey: key) {
            return loader
        } else {
            let loader = ImageLoader(path, size)
            loaders.setObject(loader, forKey: key)
            return loader
        }
    }
}
/*
 final class ImageLoader: ObservableObject {
 
 @Published var image: UIImage?
 
 private let path: String?
 private let posterStyle: PosterStyle.Size
 private var hasLoaded = false
 
 private var task: Task<UIImage, Error>?
 
 init(_ path: String?, _ size: PosterStyle.Size) {
 self.path = path
 self.posterStyle = size
 }
 
 @MainActor
 func loadImage() async {
 
 
 guard image == nil && task == nil else { return }
 
 guard !hasLoaded else { return }
 
 guard let poster = path, let url = URL(string: poster) else {
 hasLoaded = true
 return
 }
 
 task = Task { () -> UIImage in
 return try await ImageService.shared.fetchImage(url: url)
 }
 do {
 if let image = try await task?.value {
 self.image = await resize(image)
 }
 }catch {
 print(error)
 }
 
 hasLoaded = true
 }
 
 private func resize(_ image: UIImage) async -> UIImage? {
 return ImageEditor.resize(image, to: CGSize(width: self.posterStyle.width, height: self.posterStyle.height))
 }
 
 deinit {
 task?.cancel()
 print("deinit")
 }
 }
 */

final class ImageLoader: ObservableObject {
    
    private let path: String?
    private let size: PosterStyle.Size
    
    @Published var image: UIImage? = nil
    var objectWillChange: AnyPublisher<UIImage?, Never> = Publishers.Sequence<[UIImage?], Never>(sequence: []).eraseToAnyPublisher()
    private var cancellable: AnyCancellable?
    
    init(_ path: String?, _ size: PosterStyle.Size) {
        self.path = path
        self.size = size
        
        self.objectWillChange = $image.handleEvents(receiveSubscription: { [weak self] sub in
            self?.loadImage()
        }, receiveCancel: { [weak self] in
            self?.cancellable?.cancel()
        }).eraseToAnyPublisher()
    }
    
    
    private func loadImage() {
        
        guard image == nil else { return }
        
        guard let poster = path, let url = URL(string: poster) else {
            self.image = UIImage(named: "bicycle")
            return
        }
        
        cancellable = ImageService.shared.fetchImage(url, size)
            .receive(on: DispatchQueue.main)
            .assign(to: \ImageLoader.image, on: self)
        
    }
    
    deinit {
        cancellable?.cancel()
    }
}

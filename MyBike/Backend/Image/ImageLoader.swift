//
//  ImageData.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 09/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import Combine

class ImageLoaderCache {
    
    static let shared = ImageLoaderCache()
    
    private var loaders: NSCache<NSString, ImageLoader> = NSCache()
    
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

//final class ImageLoader: ObservableObject {
//
//    @Published var image: UIImage?
//
//    private let path: String?
//    private let size: PosterStyle.Size
//    private var hasLoaded = false
//
//    private var task: Task<UIImage, Error>?
//
//    init(_ path: String?, _ size: PosterStyle.Size) {
//        self.path = path
//        self.size = size
//    }
//
//    @MainActor
//    func loadImage() async {
//
//        guard image == nil && task == nil else { return }
//
//        guard !hasLoaded else { return }
//
//        guard let poster = path, let url = URL(string: poster) else {
//            hasLoaded = true
//            return
//        }
//
//        task = Task { () -> UIImage in
//            return try await ImageService.shared.asyncImage(url, size)
//        }
//        do {
//            if let image = try await task?.value {
//                self.image = await resize(image)
//            }
//        }catch {
//            print(error)
//        }
//
//        hasLoaded = true
//    }
//
//    private func resize(_ image: UIImage) async -> UIImage? {
//        return ImageEditor.resize(image, to: size.width)
//    }
//
//    deinit {
//        task?.cancel()
//        print("deinit")
//    }
//}

//final class ImageLoader: ObservableObject {
//
//    private let urlString: String?
//    private let posterSize: PosterStyle.Size
//    private var hasLoaded = false
//
//    @Published var image: UIImage? = nil
//    private var task: Task<(UIImage), Error>?
//
//    init(_ urlString: String?, _ posterSize: PosterStyle.Size) {
//        self.urlString = urlString
//        self.posterSize = posterSize
//        Task {
//            await loadImage()
//        }
//    }
//
//    @MainActor
//    func loadImage() async {
//
//        guard image == nil && task == nil else { return }
//        guard !hasLoaded else { return }
//
//        guard let path = urlString, let url = URL(string: path) else {
//            image = UIColor.random.getImage(with: posterSize.cgSize)
//            hasLoaded = true
//            return
//        }
//        task = Task { () -> UIImage in
//            return try await ImageService.shared.asyncImage(url, posterSize)
//        }
//        do {
//            self.image = try await task?.value
//        }catch {
//            print(error)
//            self.image = UIColor.random.getImage(with: self.posterSize.cgSize)
//        }
//        hasLoaded = true
//    }
//
//    deinit {
//        task?.cancel()
//    }
//}

final class ImageLoader: ObservableObject {
    static let emptyImage = UIColor.systemGray4.getImage(with: .init(width: 10, height: 10 * PosterStyle.aspectRatio))
    public let path: String
    private let posterSize: PosterStyle.Size

    public var objectWillChange: AnyPublisher<UIImage?, Never> = Publishers.Sequence<[UIImage?], Never>(sequence: []).eraseToAnyPublisher()

    @Published public var image: UIImage? = nil

    public var cancellable: AnyCancellable?

    public init(_ urlString: String, _ posterSize: PosterStyle.Size) {
        self.posterSize = posterSize
        self.path = urlString

        self.objectWillChange = $image.handleEvents(receiveSubscription: { sub in
            self.loadImage()
        }, receiveCancel: {
            self.cancellable?.cancel()
        }).eraseToAnyPublisher()
    }

    private func loadImage() {
        guard image == nil else { return }
        guard let url = URL(string: path) else {
            self.image = UIColor.random.getImage(with: posterSize.cgSize)
            return
        }
        cancellable = ImageService.shared.fetchImage(url, posterSize)
            .receive(on: DispatchQueue.main)
            .assign(to: \ImageLoader.image, on: self)
    }

    deinit {
        cancellable?.cancel()
    }
}

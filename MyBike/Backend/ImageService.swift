//
//  ImageService.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 07/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import Combine
import UIKit

class ImageService {
    
    static let shared = ImageService()
    private let urlSession = URLSession.shared
    
    enum ImageError: Error {
        case statusNotOk, imageError
    }

//    func fetchImage(url: URL) async throws -> UIImage {
//        let fetchTask = Task { () throws -> UIImage in
//            let (data, response) = try await urlSession.data(from: url)
//            try Task.checkCancellation()
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                throw ImageError.statusNotOk
//            }
//            guard let image = UIImage(data: data) else {
//                throw ImageError.imageError
//            }
//            return image
//        }
//        fetchTask.cancel()
//        return try await fetchTask.value
//        let (data, response) = try await urlSession.data(from: url)
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw ImageError.statusNotOk
//        }
//        guard let image = UIImage(data: data) else {
//            throw ImageError.imageError
//        }
//        return image
//    }
    

    func fetchImage(_ url: URL, _ size: PosterStyle.Size) -> AnyPublisher<UIImage?, Never> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> UIImage? in
                return self.resize(UIImage(data: data), size)
        }.catch { error in
            return Just(nil)
        }
        .eraseToAnyPublisher()
    }
    private func resize(_ image: UIImage?, _ size: PosterStyle.Size) -> UIImage? {
        guard let image = image else { return nil }
        return ImageEditor.resize(image, to: CGSize(width: size.width, height: size.height))
    }
}

//
//  Home_Grid_Section_ImageCarousellManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 31/12/21.
//

import Foundation
import FirebaseStorage

final class Home_Grid_Section_ImageCarousellManager: ObservableObject, StringRepresentable {
    static let shared = Home_Grid_Section_ImageCarousellManager()
    @Published var imageDatas: [ImageData] = [ImageData(file_path: "https://firebasestorage.googleapis.com:443/v0/b/mybike-a2a75.appspot.com/o/home_images%2F269839449_3141349156102618_307188297521216765_n.jpg?alt=media&token=ac78641d-bef4-4d0e-9ba3-1873688ccc44"), ImageData(file_path: "https://firebasestorage.googleapis.com:443/v0/b/mybike-a2a75.appspot.com/o/home_images%2Fa_perfect_christmas_gift_cover_1.jpg?alt=media&token=9731f1a3-94c4-43d6-aa46-c1ed023da2c6")]
    
    func getImages() {
    
//        Storage.storage().reference().child("home_images").listAll { [weak self] (result, error) in
//
//            DispatchQueue.main.async {
//
//
//                let group = DispatchGroup()
//                var imageDatas = [ImageData]()
//                result.items.forEach { item in
//                    group.enter()
//                    item.downloadURL { url, error in
//                        if let url = url {
//                            print(url.absoluteString)
//                            imageDatas.append(ImageData(file_path: url.absoluteString))
//                        }
//                        group.leave()
//                    }
//                }
//                group.notify(queue: .main) {
//                    guard let self = self else { return }
//                    self.imageDatas = imageDatas
//                }
//            }
//        }
//
    }
    
    
    deinit {
        print(stringValue)
    }
}

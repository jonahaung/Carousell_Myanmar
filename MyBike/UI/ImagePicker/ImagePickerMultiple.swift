//
//  ImagePicker.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/11/21.
//

import PhotosUI
import SwiftUI

struct ImagePickerMultiple: UIViewControllerRepresentable {
    
    var maxLimit: Int = 5
    var completion: ((_ selectedImage: [UIImage]) -> Void)? = nil
    
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = maxLimit
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_: PHPickerViewController, context _: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        
        private let parent: ImagePickerMultiple
        
        init(_ parent: ImagePickerMultiple) {
            self.parent = parent
        }
        
        func picker(_: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            let group = DispatchGroup()
            var images = [UIImage]()
            for result in results {
                group.enter()
                load(result) { image in
                    if let image = image, let squareImage = ImageEditor.cropImageToSquare(image: image) {
                        let resizedImage = ImageEditor.resize(squareImage, to: CGSize(width: 200, height: 200))
                        images.append(resizedImage)
                    }
                    group.leave()
                }
            }
            group.notify(queue: .main) { [weak self] in
                guard let self = self else { return }
                self.parent.completion?(images)
                self.parent.presentationMode.wrappedValue.dismiss()
            }
        }
        
        private func load(_ image: PHPickerResult, completion: @escaping (UIImage?) -> Void ) {
            image.itemProvider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) { (data, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    print("unable to unwrap image as UIImage")
                    completion(nil)
                    return
                }
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                completion(image)
            }
        }
    }
}

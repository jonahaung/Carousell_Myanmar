//
//  ImagePickerSingle.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import SwiftUI

struct ImagePickerSingle: UIViewControllerRepresentable {
    
    var completion: ((_ selectedImage: UIImage) -> Void)? = nil
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .savedPhotosAlbum
        controller.allowsEditing = true
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_: UIImagePickerController, context _: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        private let parent: ImagePickerSingle
        
        init(_ parent: ImagePickerSingle) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage, let squaredImage = ImageEditor.cropImageToSquare(image: image) {
                parent.completion?(ImageEditor.resize(squaredImage, to: CGSize(width: 200, height: 200)))
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
}

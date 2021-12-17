//
//  ImagePickerSingle.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import SwiftUI

struct ImagePickerSingle: UIViewControllerRepresentable {

    var autoDismiss = true
    var onPick: (UIImage) -> Void
    
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
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
            DispatchQueue.main.async {
                if let image = info[.originalImage] as? UIImage ?? info[.editedImage] as? UIImage{
                    self.parent.onPick(image)
                    if self.parent.autoDismiss {
                        self.parent.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

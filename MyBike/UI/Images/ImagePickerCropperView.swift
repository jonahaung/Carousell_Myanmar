//
//  ImagePickerCropperView.swift
//  MyBike
//
//  Created by Aung Ko Min on 10/12/21.
//

import SwiftUI
import Mantis

struct ImagePickerCropperView: View {
    
    var onPick: (UIImage) -> Void
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State var shape: Mantis.CropShapeType = .rect
    @State var ratio: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1/PosterStyle.aspectRatio)
    @State private var image: UIImage?
    
    var body: some View {
        ImagePickerSingle(autoDismiss: false, onPick: { pickedImage in
            self.image = pickedImage
        })
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(item: $image) { image in
            ImageCropper(cropShapeType: $shape, presetFixedRatioType: $ratio, image: image) {
                let resized = ImageEditor.resize($0, to: 200)
                print(resized.size, $0.size)
                onPick(resized)
                presentationMode.wrappedValue.dismiss()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

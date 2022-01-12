//
//  SellingImagesView.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import SwiftUI
import Mantis

struct SellingImage: Identifiable {
    var id = UUID().uuidString
    var image: UIImage?
}
extension SellingImage: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension UIImage: Identifiable {
    
}

struct SellImagesSection: View {

    @Binding var sellingItem: SellingItem
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(sellingItem.images) { image in
                        UpdatableImageView(sellingImage: image) {
                            if let index = sellingItem.images.firstIndex(of: image) {
                                sellingItem.images.remove(at: index)
                            }
                        }
                    }
                    
                    if sellingItem.images.count < 5 {
                        VStack {
                            Image(systemName: "plus")
                                .font(.system(size: 50))
                                .imageScale(.large)
                                .padding()
                        }
                        .frame(width: 200, height: 200)
                        .tapToPresent(imagePickerCropper, true)
                    }
                }
            }
            
            HStack {
                Button("Reset") {
                    withAnimation {
                        sellingItem.images.removeAll()
                    }
                }
                .disabled(sellingItem.images.isEmpty)
                Spacer()
                Text("\(sellingItem.images.count) of 5")
                    .italic()
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private var imagePickerCropper: some View {
        ImagePickerCropperView { image in
            sellingItem.images.append(SellingImage(image: image))
        }
    }
}

struct UpdatableImageView: View {
    
    @State var sellingImage: SellingImage
    
    var onDelete: () -> Void
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Image(uiImage: sellingImage.image ?? UIImage())
                    .resizable()
                    .scaledToFit()
                HStack {
                    Text("Edit")
                        .tapToPresent(imageCropper(), true)
                    Spacer()
                    Button {
                        withAnimation {
                            onDelete()
                        }
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                .padding().accentColor(.white)
            }
        }
        .frame(width: 170, height: 170 * PosterStyle.aspectRatio)
        .tapToPresent(imagePiker, false)
    }
    
    private var imagePiker: some View {
        ImagePickerCropperView {
            sellingImage.image = $0
        }
    }
    
    private func imageCropper() -> some View {
        let shape: Mantis.CropShapeType = .rect
        let ratio: Mantis.PresetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1/PosterStyle.aspectRatio)
        
        return ImageCropper(cropShapeType: .constant(shape), presetFixedRatioType: .constant(ratio), image: sellingImage.image!) { image in
            sellingImage.image = image
        }.edgesIgnoringSafeArea(.all)
    }
}

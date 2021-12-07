//
//  SellingImagesView.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import SwiftUI

struct SellingImage {
    var id = UUID().uuidString
    var image: UIImage?
    var displayedImage: UIImage { image ?? UIImage(systemName: "plus")! }
}
extension SellingImage: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct SellImagesSection: View {
    
    @StateObject var itemSeller: ItemSeller
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach($itemSeller.sellingImages, id: \.self) {
                    UpdatableImageView(sellingImage: $0)
                }
                if itemSeller.sellingImages.count <= 5 {
                    Button {
                        itemSeller.fullScreenType = .imagesPicker
                    } label: {
                        VStack {
                            Image(systemName: "plus")
                                .font(.system(size: 50))
                                .imageScale(.large)
                                .padding()
                        }
                        .frame(width: 200, height: 200)
                    }
                }
            }
        }
    }
}

struct UpdatableImageView: View {
    
    @Binding var sellingImage: SellingImage
    @State private var showImagePicker = false
    
    var body: some View {
        Image(uiImage: sellingImage.displayedImage)
            .resizable()
            .scaledToFit()
            .imageScale(.large)
            .onTapGesture {
                showImagePicker = true
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePickerSingle {
                    sellingImage.image = $0
                }.edgesIgnoringSafeArea(.all)
            }
    }
}

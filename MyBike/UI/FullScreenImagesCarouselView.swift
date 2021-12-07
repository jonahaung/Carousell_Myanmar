//
//  MoviePostersCarouselView.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 23/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct FullScreenImagesCarouselView : View {
    
    let imageDatas: [ImageData]
    @State var selectedData: ImageData
    @State private var scale: CGFloat = 1.0
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        TabView(selection: $selectedData) {
            ForEach(imageDatas) { data in
                ItemImageView(data.file_path, .big)
                    .tag(data)
                    .scaleEffect(scale)
                    .gesture(magnificationGesture)
                    .gesture(doubleTapGesture)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .automatic))
        .overlay(alignment: .topTrailing) {
            Button("Done") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .accentColor(.white)
        }
        .background(Rectangle().fill(Color.black)
                        .edgesIgnoringSafeArea(.all))
    }
    private var magnificationGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                self.scale = value.magnitude
            }
            .onEnded { value in
                withAnimation {
                    self.scale = 1
                }
            }
    }
    
    private var doubleTapGesture: some Gesture {
        TapGesture(count: 2).onEnded({ _ in
            withAnimation{
                self.scale = self.scale == 1 ? 1.8 : 1
            }
        })
    }
}

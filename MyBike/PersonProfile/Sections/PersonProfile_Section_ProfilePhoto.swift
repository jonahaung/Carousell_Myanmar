//
//  PersonProfile_Section_ProfilePhoto.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/12/21.
//

import SwiftUI

struct PersonProfile_Section_ProfilePhoto: View {
    
    @EnvironmentObject private var personViewModel: PersonViewModel
    
    var body: some View {
        VStack {
            let imageData = ImageData(file_path: personViewModel.photoUrl)
            PersonImageView(personViewModel.photoUrl, .big).shadow(radius: 6)
                .tapToPresent(FullScreenImagesCarouselView(imageDatas: [imageData], selectedData: .constant(imageData)), true)
            Spacer()
            
            HStack {
                Image(systemName: "square.and.arrow.up")
                Image(systemName: "qrcode")
                Spacer()
            }
            .imageScale(.large)
            
        
            HStack(spacing: 15) {
                Person_Profile_Rating(personViewModel: personViewModel)
                Text("\(personViewModel.ratings.count) ratings")
                    .tapToPush(Text("Ratings View"))
                Spacer()
                let overall = personViewModel.ratings.overallRating
                PopularityBadge(score: (100*overall)/5)
            }
        }
        .padding()
    }
}

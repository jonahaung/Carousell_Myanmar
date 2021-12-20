//
//  RatingView.swift
//  MyBike
//
//  Created by Aung Ko Min on 21/12/21.
//

import SwiftUI

struct RatingView: View {
    
    @EnvironmentObject private var personViewModel: PersonViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            let overall = personViewModel.ratings.overallRating
            ForEach(0..<5, id:\.self) { i in
                let imageName = (i + 1) <= overall ? "star.fill" : "star"
                Image(systemName: imageName)
            }
        }
    }
}

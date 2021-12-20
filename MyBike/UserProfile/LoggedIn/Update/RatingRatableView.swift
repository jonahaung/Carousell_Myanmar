//
//  RatingView.swift
//  MyBike
//
//  Created by Aung Ko Min on 21/12/21.
//

import SwiftUI

struct RatingRatableView: View {
    
    @EnvironmentObject private var manager: UserProfileUpdateManager
    @State private var currentRate: Int = 0
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(1..<6, id:\.self) { i in
                Image(systemName: i <= currentRate ? "star.fill" : "star")
                    .onTapGesture {
                    Vibration.light.vibrate()
                    currentRate = i
                        rate()
                }
                .foregroundColor(i <= currentRate ? .blue : .tertiaryLabel)
            }
            Text("\(currentRate)/5").italic().padding()
        }
        .imageScale(.medium)
        .onAppear {
            currentRate = manager.personViewModel.ratings.overallRating
        }
    }
    
    private func rate() {
        let rating = Person.Ratings.Rating.init(person: .init(manager.personViewModel.person), value: currentRate)
        print(rating)
        manager.personViewModel.ratings.values.insert(rating, at: 0)
//        if !manager.personViewModel.ratings.hasRated {
//            let rating = Person.Ratings.Rating.init(person: .init(manager.personViewModel.person), value: currentRate)
//            manager.personViewModel.ratings.values.insert(rating, at: 0)
//        }
    }
}

//
//  RatingView.swift
//  MyBike
//
//  Created by Aung Ko Min on 21/12/21.
//

import SwiftUI

struct Person_Profile_Rating_Editable: View {
    
    @EnvironmentObject private var currentUserViewModel: CurrentUserViewModel
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
                .foregroundColor(i <= currentRate ? .accentColor : .tertiaryLabel)
            }
            Text("\(currentRate)/5").italic().padding()
        }
        .imageScale(.medium)
        .onAppear {
            currentRate = currentUserViewModel.ratings.overallRating
        }
    }
    
    private func rate() {
        let rating = Person.Ratings.Rating.init(person: currentUserViewModel.person.briefPerson(), value: currentRate)
        print(rating)
        currentUserViewModel.ratings.values.insert(rating, at: 0)
//        if !manager.personViewModel.ratings.hasRated {
//            let rating = Person.Ratings.Rating.init(person: .init(manager.personViewModel.person), value: currentRate)
//            manager.personViewModel.ratings.values.insert(rating, at: 0)
//        }
    }
}

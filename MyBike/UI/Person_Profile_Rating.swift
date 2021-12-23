//
//  RatingView.swift
//  MyBike
//
//  Created by Aung Ko Min on 21/12/21.
//

import SwiftUI

struct Person_Profile_Rating: View {
    
    @StateObject var personViewModel: PersonViewModel
    
    var body: some View {
        HStack(spacing: 1) {
            let overall = personViewModel.ratings.overallRating
            ForEach(0..<overall) { i in
                Image(systemName: "circle.fill")
                    .foregroundColor(getColor(i: i+1).opacity(0.7))
            }
        }
        .imageScale(.medium)
        
    }
    
    private func getColor(i: Int) -> Color {
        switch i {
        case 1: return .pink
        case 2: return .orange
        case 3: return .yellow
        case 4: return .green
        case 5: return .blue
        default:
            return .clear
        }
    }
}

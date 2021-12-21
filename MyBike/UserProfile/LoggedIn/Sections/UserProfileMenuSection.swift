//
//  UserProfileMenuSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 21/12/21.
//

import SwiftUI

struct UserProfileMenuSection: View {
    
    @EnvironmentObject private var currentUserViewModel: CurrentUserViewModel
    private let spacing = 20.0
    
    var body: some View {
        VStack(spacing: spacing) {
            HStack(spacing: spacing) {
                Group {
                    Image(systemName: "books.vertical.fill")
                        .resizable()
                    Image(systemName: "bell.badge.fill")
                        .resizable()
                    Image(systemName: "clock.fill")
                        .resizable()
                    Image(systemName: "bolt.heart.fill")
                        .resizable()
                        .tapToPushItemsList(.favourites)
                }
                .scaledToFit()
                .frame(width: 50)
            }
            HStack(spacing: spacing) {
                Group{
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .resizable()
                    Image(systemName: "message.fill")
                        .resizable()
                    Image(systemName: "ferry.fill")
                        .resizable()
                    Image(systemName: "barcode")
                        .resizable()
                }
                .scaledToFit()
                .frame(width: 50)
            }
        }
        .padding()
        .foregroundStyle(.secondary)
        .zIndex(5)
        
    }
}

struct UserProfileMenuSection_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileMenuSection()
    }
}

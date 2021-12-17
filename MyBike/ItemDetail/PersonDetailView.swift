//
//  PersonDetailView.swift
//  MyBike
//
//  Created by Aung Ko Min on 11/11/21.
//

import SwiftUI

struct PersonDetailView: View {
    
    @ObservedObject var personViewModel: PersonViewModel
    
    var body: some View {
        Group {
            Section{
                if let url = personViewModel.photoUrl {
                    PersonImageView(url, .big)
                }
            }
            Section{
                Text("User Name").badge(personViewModel.name)
                Text("Email").badge(personViewModel.email)
            }
        }
    }
}

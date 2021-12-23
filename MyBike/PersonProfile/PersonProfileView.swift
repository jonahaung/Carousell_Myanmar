//
//  PersonProfileView.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/12/21.
//

import SwiftUI

struct PersonProfileView: View {
    
    @EnvironmentObject private var personViewModel: PersonViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            PersonProfile_Section_ProfilePhoto()
            PersonProfile_Section_About()
        }
        .background(Color.groupedTableViewBackground)
        .navigationTitle(personViewModel.name)
    }
    
}

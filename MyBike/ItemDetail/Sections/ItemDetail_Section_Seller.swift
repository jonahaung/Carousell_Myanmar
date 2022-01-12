//
//  ItemSellerSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemDetail_Section_Seller: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    
    var body: some View {
        Group {
            if let person = itemViewModel.person {
                HStack {
                    if let urlString = person.photoUrl {
                        PersonImageView(urlString, .medium)
                    }

                    VStack(spacing: 8) {
                        Text(person.userName)
                            .tapToPush(PersonProfileView().environmentObject(PersonViewModel(person: person)))
                        
                        Person_Profile_Rating(personViewModel: PersonViewModel(person: person))
                    }
                    Spacer()
                }
            }
            
        }
        .insetGroupSectionStyle(innerPadding: 20)
    }
}

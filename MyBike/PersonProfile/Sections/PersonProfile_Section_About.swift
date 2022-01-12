//
//  PersonProfile_Section_About.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/12/21.
//

import SwiftUI

struct PersonProfile_Section_About: View {
    
    @EnvironmentObject private var personViewModel: PersonViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(personViewModel.name).bold()
                
                Image(systemName: personViewModel.hasEmailVerified ? "checkmark.seal.fill" : "exclamationmark.circle.fill")
                    .foregroundColor(personViewModel.hasEmailVerified ? .indigo : .pink)
                    .imageScale(.small)
            }
            
            Group {
                Label(personViewModel.userName, systemImage: "person.crop.circle.fill")
                Label(personViewModel.email, systemImage: "at.circle.fill")
                Label(personViewModel.phone, systemImage: "phone.circle.fill")
                Label.init("\(personViewModel.address.township) \(personViewModel.address.state)", systemImage: "map.circle.fill")
            }
            
            Divider()
            Group {
                FormCell("Member Since") { Text(personViewModel.person.userMetadata.creationDate.relativeString) }
                FormCell("Last Login") { Text(personViewModel.person.userMetadata.lastSignInDate.relativeString) }
            }
            
        }
        .insetGroupSectionStyle()
    }
}

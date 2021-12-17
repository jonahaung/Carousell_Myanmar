//
//  FormCell.swift
//  MyBike
//
//  Created by Aung Ko Min on 10/12/21.
//

import SwiftUI

struct FormCell: View {
    
    let text: String
    let rightView: AnyView
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(.secondary)
            Spacer()
            rightView
                .font(.Serif())
                .multilineTextAlignment(.trailing)
                
        }
    }
}

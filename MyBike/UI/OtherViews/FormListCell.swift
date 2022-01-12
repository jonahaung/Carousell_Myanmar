//
//  FormListCell.swift
//  MyBike
//
//  Created by Aung Ko Min on 10/1/22.
//

import SwiftUI

struct FormListCell<Content: View>: View {
    
    private let iconName: String?
    private let leftView: () -> Content
    
    init(iconName: String? = nil, @ViewBuilder leftView: (@escaping () -> Content)) {
        self.iconName = iconName 
        self.leftView = leftView
    }
    
    var body: some View {
        HStack {
            if let iconName = iconName {
                Image(systemName: iconName)
                    .foregroundColor(.primary)
                    .scaledToFit()
            }
            leftView()
            Spacer()

        }
        Divider().padding(.leading)
    }
}

//
//  FormCell.swift
//  MyBike
//
//  Created by Aung Ko Min on 10/12/21.
//

import SwiftUI

struct FormCell<Content: View>: View {
    
    private let text: String
    let content: () -> Content
    
    init(_ text: String, @ViewBuilder _ rightView: @escaping () -> Content) {
        self.text = text
        self.content = rightView
    }
    
    var body: some View {
        HStack {
            Text(text)
                
            Spacer()
            content()
        }
        Divider()
    }
}

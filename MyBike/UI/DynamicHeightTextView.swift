//
//  DynamicHeightTextView.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/11/21.
//

import Foundation
import SwiftUI


struct DynamicHeightTextView: View {
    
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text(text)
                .padding(3)
                .foregroundColor(.clear)
            TextEditor(text: $text)
                .frame(minHeight: 100, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
    }
}

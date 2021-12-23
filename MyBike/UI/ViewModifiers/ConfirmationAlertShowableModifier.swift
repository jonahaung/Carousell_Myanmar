//
//  ConfirmationAlertShowableModifier.swift
//  MyBike
//
//  Created by Aung Ko Min on 23/12/21.
//

import SwiftUI

struct ConfirmationAlertShowableModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.quaternary, in: Capsule())
    }
}



//
//  EmbeddedInNavigationViewModifier.swift
//  MyBike
//
//  Created by Aung Ko Min on 23/12/21.
//

import Foundation
import SwiftUI

struct EmbeddedInNavigationViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        NavigationView {
            content
                .background(Color.groupedTableViewBackground)
        }
        .navigationViewStyle(.stack)
    }
}
extension View {
    func embeddedInNavigationView() -> some View {
        ModifiedContent(content: self, modifier: EmbeddedInNavigationViewModifier())
    }
}

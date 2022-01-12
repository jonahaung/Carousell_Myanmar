//
//  EmbeddedInNavigationViewModifier.swift
//  MyBike
//
//  Created by Aung Ko Min on 23/12/21.
//

import Foundation
import SwiftUI

struct EmbeddedInNavStyle: ViewModifier {

    let title: String
    
    func body(content: Content) -> some View {
        NavigationView {
            content
                .navigationTitle(title)
        }
        .navigationViewStyle(.stack)
    }
}

extension View {
    func embeddedInNavigationView(_ title: String = String()) -> some View {
        ModifiedContent(content: self, modifier: EmbeddedInNavStyle(title: title))
    }
}


struct EmbeddedInNavigationVieWithCancelButtonwModifier: ViewModifier {
    
    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        NavigationView {
            content
                .background(Color.groupedTableViewBackground)
                .navigationBarItems(trailing: doneButton)
        }
        .navigationViewStyle(.stack)
    }
    
    private var doneButton: some View {
        Button("Done") {
            dismiss()
        }
    }
}
extension View {
    func embeddedInNavigationViewWithCancelButton() -> some View {
        ModifiedContent(content: self, modifier: EmbeddedInNavigationVieWithCancelButtonwModifier())
    }
}

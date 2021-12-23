//
//  AlertObject.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import SwiftUI

class AlertObject: Identifiable {
    
    var id: String { return title }
    var title: String
    let buttonText: String
    var show: Bool = true
    let action: (() -> Void)?
    let cancelAction: (() -> Void)?
    let role: ButtonRole?
    
    init(_ title: String = "", buttonText: String = "Okay", role: ButtonRole? = nil, show: Bool = true, action: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil) {
        self.title = title
        self.buttonText = buttonText
        self.show = show
        self.action = action
        self.cancelAction = cancelAction
        self.role = role
    }
}

struct AlertModifier: ViewModifier {
    
    @Binding var alert: AlertObject
    
    func body(content: Content) -> some View {
        content
            .confirmationDialog(alert.title, isPresented: $alert.show, titleVisibility: alert.title.isEmpty ? .hidden : .visible, presenting: alert) {
                Button($0.buttonText, role: $0.role, action: $0.action ?? {})
        }
    }
}

extension View {
    func confirmationAlert(_ alert: Binding<AlertObject>) -> some View {
        return ModifiedContent(content: self, modifier: AlertModifier(alert: alert))
    }
}

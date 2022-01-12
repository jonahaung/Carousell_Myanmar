//
//  MessagesView.swift
//  MyBike
//
//  Created by Aung Ko Min on 7/12/21.
//

import SwiftUI

struct MessagesView: View {
    @Environment(\.dismiss) var dismiss
    struct ToggleStates {
        var oneIsOn: Bool = false
        var twoIsOn: Bool = true
    }
    
    @State private var toggleStates = ToggleStates()
    @State private var topExpanded: Bool = true
    
    var body: some View {
        CustomScrollView {
            DisclosureGroup("Hello", isExpanded: $topExpanded) {
                Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                DisclosureGroup("Sub-items") {
                    Text("Sub-item 1")
                }
            }
            .insetGroupSectionStyle()
        }
        .refreshable {
            print("hahah")
        }
        .embeddedInNavigationView("Notifications")
    }
    
}

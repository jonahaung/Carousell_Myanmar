//
//  TapToShowActionSheetView.swift
//  MyBike
//
//  Created by Aung Ko Min on 2/1/22.
//

import SwiftUI

struct TapToShowActionSheetView<Content: View>: View {
    
    private let content: Content
    private let actionSheet: ActionSheet
    
    @State private var showActionSheet = false
    
    init(actionSheet: ActionSheet, content: Content) {
        self.content = content
        self.actionSheet = actionSheet
    }
    
    var body: some View {
        Button {
            showActionSheet = true
            Vibration.medium.vibrate()
        } label: {
            content
        }
        .actionSheet(isPresented: $showActionSheet) {
            actionSheet
        }
    }
}

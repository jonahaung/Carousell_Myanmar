//
//  BackgroundStyle.swift
//  MyBike
//
//  Created by Aung Ko Min on 11/1/22.
//

import SwiftUI

struct WithBackgroundStyle: ViewModifier {

    func body(content: Content) -> some View {
        content.background(Color.groupedTableViewBackground.frame(height: 99999999))
    }
}
extension View {
    func withBackground() -> some View {
        ModifiedContent(content: self, modifier: WithBackgroundStyle())
    }
}

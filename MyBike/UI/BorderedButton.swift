//
//  BorderedButton.swift
//  MyBike
//
//  Created by Aung Ko Min on 11/11/21.
//

import SwiftUI

public struct BorderedButton : View {
    public let text: String
    public let systemImageName: String
    public let color: Color
    public let isOn: Bool
    public let action: () -> Void
    
    public init(text: String, systemImageName: String, color: Color, isOn: Bool, action: @escaping () -> Void) {
        self.text = text
        self.systemImageName = systemImageName
        self.color = color
        self.isOn = isOn
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            self.action()
        }, label: {
            HStack(alignment: .center, spacing: 4) {
                Image(systemName: systemImageName).foregroundColor(isOn ? .white : color)
                Text(text).foregroundColor(isOn ? .white : color)
            }
            })
            .buttonStyle(BorderlessButtonStyle())
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            .background(RoundedRectangle(cornerRadius: 8)
                .stroke(color, lineWidth: isOn ? 0 : 1)
                .background(isOn ? color : .clear)
                .cornerRadius(8))
    }
}

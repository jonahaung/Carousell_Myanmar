//
//  NotificationBadge.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 15/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct NotificationBadge : View {
    
    @Binding var notification: Notification
    @State private var show = false
    @State private var timer: Timer?
    
    var body: some View {
        Text(notification.text)
            .foregroundColor(.secondarySystemGroupedBackground)
            .font(.subheadline)
            .padding()
            .background(notification.color)
            .cornerRadius(8)
            .zIndex(3)
            .scaleEffect(show ? 1: 0.5)
            .opacity(show ? 1 : 0)
            .animation(Animation.spring().speed(2))
            .onChange(of: notification, perform: onChange(_:))
    }
    
    
    private func onChange(_ notification: Notification) {
        if !notification.text.isEmpty {
            show = true
            ToneManager.playSound(tone: .Tock)
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
                self.notification.text = ""
                show.toggle()
                timer.invalidate()
            }
        }
    }
}

extension NotificationBadge {
    
    struct Notification: Equatable {
        var text: String
        var priority: Priority
        
        init( _ text: String, _ priority: Priority) {
            self.text = text
            self.priority = priority
        }
        
        var color: Color {
            switch self.priority {
                case .Success: return .blue
                case .Warning: return .yellow
                case .Error: return .pink
            }
        }
        
        static func == (lhs: NotificationBadge.Notification, rhs: NotificationBadge.Notification) -> Bool {
            return lhs.text == rhs.text && lhs.priority == rhs.priority
        }
        
        enum Priority {
            case Success, Warning, Error
        }
    }
}

//
//  AppAlertManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 23/12/21.
//

import SwiftUI

final class AppAlertManager: ObservableObject {
    
    static let shared = AppAlertManager()
    
    @Published var alert = AlertObject(show: false)
    
    @Published var notification: NotificationBadge.Notification = .init("", .Success)
    
    var isSearching = false {
        willSet {
            guard newValue != isSearching else { return }
            withAnimation(.interactiveSpring()) {
                objectWillChange.send()
            }
        }
    }
    
    func onComfirm(buttonText: String, _ done: @escaping () -> Void, cancel: (() -> Void)? = nil) {
        alert = AlertObject(buttonText: buttonText, action: done, cancelAction: cancel)
    }
}

//
//  AppAlertManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 23/12/21.
//

import Foundation

final class AppAlertManager: ObservableObject {
    
    static let shared = AppAlertManager()
    
    @Published var alert = AlertObject(show: false)
    
}

//
//  UserDefaultManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/11/21.
//

import Foundation

class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    
    private let defaults = UserDefaults.standard
    
    let _homeMode = "homeMode"
    
    var homeMode: Int {
        get {
            return defaults.integer(forKey: _homeMode)
        } set {
            defaults.setValue(newValue, forKey: _homeMode)
        }
    }
    
}

//
//  UserDetaultWrapper.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 12/07/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import Foundation

//@propertyWrapper
//public struct UserDefault<T> {
//    let key: String
//    let defaultValue: T
//    
//    init(_ key: String, defaultValue: T) {
//        self.key = key
//        self.defaultValue = defaultValue
//    }
//    
//    public var wrappedValue: T {
//        get {
//            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: key)
//        }
//    }
//}

@propertyWrapper
public struct UserDefaultRaw<T: RawRepresentable> {
    
    private let key: String
    private let defaultValue: T
    
    init(_ key: String, _ defaultValue: T) where T: RawRepresentable {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            guard let rawValue = UserDefaults.standard.object(forKey: key) as? T.RawValue else { return defaultValue }
            return T(rawValue: rawValue)  ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: key)
        }
    }
}

//
//  UserDefaultManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/11/21.
//

import SwiftUI
import FirebaseFirestore

final class AppUserDefault: ObservableObject {
    
    static let shared = AppUserDefault()
    
    private static let _appTintColor = "appTintColor"
    private static let _isLocalStoreCached = "isLocalStoreCached"
    private static let _isRemoteStoreCached = "isRemoteStoreCached"
    private static let _isFireStoreCached = "isFireStoreCached "
    private static let _currentTab = "currentTab"
    private static let _queryLimit = "queryLimit"
    
    @AppStorage(AppUserDefault._queryLimit) var maxQueryLimit: Int = 10
    @AppStorage(AppUserDefault._isLocalStoreCached) var isCachedForRemoteData: Bool = false
    @AppStorage(AppUserDefault._isRemoteStoreCached) var isCachedForLocalData: Bool = false
    @AppStorage(AppUserDefault._isFireStoreCached) var isCachedForeFirestoreData: Bool = Firestore.firestore().settings.isPersistenceEnabled
    
    @UserDefaultRaw(AppUserDefault._appTintColor, AppTintColor.Blue) var tintColor: AppTintColor { didSet { updateUI() } }
    @UserDefaultRaw(AppUserDefault._currentTab, CustomTabView.TabBarTab.Home) var currentTabViewTab: CustomTabView.TabBarTab { didSet { updateUI() }}
    
    private func updateUI() {
        Vibration.soft.vibrate()
        objectWillChange.send()
    }
}


extension AppUserDefault {
    
    enum AppTintColor: String, CaseIterable {
        case Blue, Red, Orange, Pink, Indigo, Teal, Green, Yellow, Mint, Cyan, Steam_Green, Steam_Gold, Steam_Blue
        var color: Color {
            switch self {
            case .Blue:
                return .blue
            case .Red:
                return .red
            case .Orange:
                return .orange
            case .Pink:
                return .pink
            case .Indigo:
                return Color(.systemIndigo)
            case .Teal:
                return Color(.systemTeal)
            case .Green:
                return .green
            case .Yellow:
                return .yellow
            case .Mint:
                return .mint
            case .Cyan:
                return .cyan
            case .Steam_Green:
                return .steam_green
            case .Steam_Gold:
                return .steam_gold
            case .Steam_Blue:
                return .steam_blue
            }
        }
    }
}

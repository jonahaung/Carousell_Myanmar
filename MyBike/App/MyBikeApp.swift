//
//  MyBikeApp.swift
//  MyBike
//
//  Created by Aung Ko Min on 12/9/21.
//

import SwiftUI
import Firebase

@main
struct MyBikeApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @Environment(\.scenePhase) private var scenePhase
   
    var body: some Scene {
        WindowGroup {
            CustomTabView()
                .environmentObject(AppAlertManager.shared)
                .environmentObject(AuthenticationService.shared)
                .environmentObject(AppUserDefault.shared)
                .environmentObject(AppBackendManager.shared)
                .redacted(reason: scenePhase == .active ? [] : .placeholder)
        }
        .onChange(of: scenePhase, perform: scenePhaseChanged(_:))
    }
}

extension MyBikeApp {
    
    private func scenePhaseChanged(_ phase: ScenePhase) {
        switch phase {
        case .active:
            print("active")
        case .inactive:
            print("inactive")
        case .background:
            print("background")
        @unknown default:
            print("unknown")
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = AppUserDefault.shared.isCachedForeFirestoreData
        Firestore.firestore().settings = settings
        
        setupApperance(color: AppUserDefault.shared.tintColor.color.uiColor)
        return true
    }
    
    private func setupApperance(color: UIColor) {
        UINavigationBar.appearance().largeTitleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont(name: "KaushanScript-Regular", size: UIFontMetrics.default.scaledValue(for: 40))!
        ]
        
        UINavigationBar.appearance().titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont(name: "KaushanScript-Regular", size: UIFont.systemFontSize)!
        ]
    
        UIWindow.appearance().tintColor = color
    }
}



extension Color {
    var uiColor: UIColor {
        UIColor(self)
    }
}

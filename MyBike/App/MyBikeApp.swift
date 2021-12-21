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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
   
    var body: some Scene {
        WindowGroup {
            CustomTabView()
//                .accentColor(.pink)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        setupApperance()
        return true
    }
    
    private func setupApperance() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "steam_gold")!,
            NSAttributedString.Key.font: UIFont(name: "FjallaOne-Regular", size: 28)!]
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "steam_gold")!,
            NSAttributedString.Key.font: UIFont(name: "FjallaOne-Regular", size: 18)!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor(named: "steam_gold")!, .font: UIFont(name: "FjallaOne-Regular", size: 16)!], for: .normal)
        
        UIWindow.appearance().tintColor = .systemMint
    }
}

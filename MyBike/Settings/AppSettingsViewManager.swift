//
//  AppSettingsViewManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 22/12/21.
//

import UIKit
import StoreKit

final class AppSettingsViewManager: ObservableObject {
    
    @Published var isCachedItem: Bool = UserDefaultManager.shared.isCachedItem {
        didSet {
            UserDefaultManager.shared.isCachedItem = isCachedItem
        }
    }
    func gotoPrivacyPolicy() {
        guard let url = URL(string: "https://bmcamera-b40b2.web.app") else {
            return //be safe
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func rateApp() {
        for scene in UIApplication.shared.connectedScenes {
            if scene.activationState == .foregroundActive {
                if let windowScene = scene as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: windowScene)
                }
                break
            }
        }
    }
    
    
    func gotoDeviceSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
}

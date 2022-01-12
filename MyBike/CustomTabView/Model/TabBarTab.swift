//
//  TabBarTab.swift
//  MyBike
//
//  Created by Aung Ko Min on 9/1/22.
//

import Foundation

extension CustomTabView {
    
    enum TabBarTab: Int, Identifiable, CaseIterable {
        
        var id: String { title }
        case Home, Messages, CurrentUserProfile, Settings
        
        var iconName: String {
            switch self {
            case .Home:
                return "flame.fill"
            case .Messages:
                return "globe.asia.australia.fill"
            case .CurrentUserProfile:
                return "person.circle.fill"
            case .Settings:
                return "gearshape.fill"
            }
        }
        var title: String {
            switch self {
            case .Home:
                return "Discover"
            case .Messages:
                return "Messages"
            case .CurrentUserProfile:
                return "User Profile"
            case .Settings:
                return "Settings"
            }
        }

    }
    
}

//
//  ViewRouter.swift
//  MyBike
//
//  Created by Aung Ko Min on 23/12/21.
//

import SwiftUI

final class ViewRouter: ObservableObject {
    
    static let shared = ViewRouter()
    
    var currentTab = Tab.Home {
        didSet {
            guard oldValue != currentTab else { return }
            ToneManager.vibrate(vibration: .light)
            withAnimation(.interactiveSpring()) {
                objectWillChange.send()
            }
        }
    }
    
    @Published var homeViewMode = HomeMode(rawValue: UserDefaultManager.shared.homeMode) ?? .grid {
        didSet {
            UserDefaultManager.shared.homeMode = self.homeViewMode.rawValue
        }
    }
    
}

extension ViewRouter {
    
    enum Tab: Int, CaseIterable, Identifiable {
        
        var id: Int { self.rawValue }
        
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
    }
    
    enum HomeMode: Int, CaseIterable {
        case grid, doubleColumn
        
        var icon: String {
            switch self {
            case .doubleColumn: return "square.grid.3x1.fill.below.line.grid.1x2"
            case .grid: return "rectangle.grid.2x2.fill"
            }
        }
        
        var description: String {
            switch self {
            case .grid:
                return "Grid"
            case .doubleColumn:
                return "Double Column"
            }
        }
    }
}

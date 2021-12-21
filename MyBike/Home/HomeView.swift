//
//  HomeView.swift
//  MyBike
//
//  Created by Aung Ko Min on 12/9/21.
//

import SwiftUI

struct HomeView: View {
    
    @State private var homeMode = HomeMode(rawValue: UserDefaultManager.shared.homeMode) ?? .grid

    @StateObject private var searchManager = SearchViewManager()
   
    var body: some View {
        NavigationView {
            Group {
                switch homeMode {
                case .list:
                    HomeAsDoubleColumnGrid()
                case .grid:
                    HomeAsGridView()
                }
            }
            
            .navigationBarItems(leading: navLeadingView, trailing: NavTrailingView)
            .navigationBarTitleDisplayMode(homeMode == .list ? .inline : .automatic)
        }
        .navigationViewStyle(.stack)
        .environmentObject(searchManager)
        .searchable(text: $searchManager.searchText, placement: .navigationBarDrawer(displayMode: homeMode == .list ? .always : .automatic), prompt: "Search")
    }
    
    private var navLeadingView: some View {
        HStack {
//            Button {
//                AppBackendManager.shared.refreshAllData()
//            } label: {
//                Image(systemName: "cart.fill")
//            }
        }
    }
    
    private var NavTrailingView: some View {
        HStack {
            Button(action: {
                withAnimation {
                    homeMode = self.homeMode == .list ? .grid : .list
                }

                UserDefaultManager.shared.homeMode = homeMode.rawValue
            }) {
                Image(systemName: self.homeMode.icon)
            }
        }
    }
}


fileprivate enum HomeMode: Int {
    case grid, list
    var icon: String {
        switch self {
        case .list: return "square.grid.3x1.fill.below.line.grid.1x2"
        case .grid: return "rectangle.grid.2x2.fill"
        }
    }
}

//
//  HomeView.swift
//  MyBike
//
//  Created by Aung Ko Min on 12/9/21.
//

import SwiftUI

struct HomeView: View {
    
    enum HomeMode: Int {
        case grid, list
        var icon: String {
            switch self {
            case .list: return "square.grid.3x1.fill.below.line.grid.1x2"
            case .grid: return "rectangle.grid.2x2.fill"
            }
        }
    }

    @State private var homeMode = HomeMode(rawValue: UserDefaultManager.shared.homeMode) ?? .grid
    @StateObject private var searchManager = SearchViewManager()
    
    var body: some View {
        NavigationView {
            Group {
                switch homeMode {
                case .list:
                    HomeAsListView()
                case .grid:
                    HomeAsGridView()
                }
            }
            .navigationBarTitleDisplayMode(homeMode == .list ? .inline : .automatic)
            .navigationBarItems(leading: navLeadingItems, trailing: navTrailingItems)
            .overlay(alignment: .bottomTrailing) { SellButtonView() }
            .environmentObject(searchManager)
        }
        .navigationViewStyle(.stack)
        .searchable(text: $searchManager.searchText, placement: .navigationBarDrawer(displayMode: homeMode == .list ? .always : .automatic), prompt: "Search")
        .onSubmit(of: .search) {
            searchManager.search()
        }
        
    }
    
    private var navLeadingItems: some View {
        Button {
            
        } label: {
            Image(systemName: "cart.fill")
        }

    }
    
    private var navTrailingItems: some View {
        HStack {
            Button(action: {
                homeMode = self.homeMode == .list ? .grid : .list
                UserDefaultManager.shared.homeMode = homeMode.rawValue
            }) {
                Image(systemName: self.homeMode.icon)
            }
        }
    }
}

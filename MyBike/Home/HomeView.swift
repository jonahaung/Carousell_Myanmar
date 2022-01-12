//
//  HomeAsGridView.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/11/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authenticationService: AuthenticationService
    @StateObject private var searchManager = SearchViewManager.shared
    
    var body: some View {
        GeometryReader { geometry in
            CustomScrollView {
                VStack {
                    Home_Grid_Section_ImageCarousell(geometry: geometry)
                    ForEach(ItemMenu.homeMenus) { HomeItemSectionList($0)}
                    
                    HomeCategoryView()
                    
                    HomeAdsView()
                    
                    if let viewedHistory = authenticationService.currentUserViewModel?.person.viewedHistory {
                        let itemMenu = ItemMenu.ViewedCategory(viewedHistory)
                        VStack(alignment: .leading, spacing: 0) {
                            ItemListTitleView(itemMenu, _showSeeAll: false)
                            ItemList(itemMenu)
                        }
                    }
                }
                .overlay(SearchView().environmentObject(searchManager))
            }
            .refreshable {
                print("hahaa")
            }
            .embeddedInNavigationView("Marketplace")
            .searchable(text: $searchManager.searchText, prompt: "Search")
        }
    }
}

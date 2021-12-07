//
//  HomeAsGridView.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/11/21.
//

import SwiftUI

struct HomeAsGridView: View {
    
    @Environment(\.isSearching) private var isSearching
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                HomeImageCarousellView()
                ForEach(AppBackendManager.shared.homeMenus) { menu in
                    switch menu {
                    case .category:
                        HomeAdView()
                        HomeCategoryListView()
                    default:
                        ItemGridView(menu)
                    }
                }
                DoubleColGrid(.suggessted)
            }
        }
        .background(Color.groupedTableViewBackground)
        .navigationBarTitle("Market Place")
        .overlay(isSearching ? SearchView().anyView : EmptyView().anyView)
        
    }
}

//
//  HomeAsGridView.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/11/21.
//

import SwiftUI

struct HomeAsGridView: View {
    
    @Environment(\.isSearching) private var isSearching
    @EnvironmentObject var appBackend: AppBackendManager
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                HomeImageCarousellView(itemViewModel: ItemViewModel(item: .mock(), person: .mock))
                ForEach(appBackend.homeMenus) { menu in
                    switch menu {
                    case .category:
                        HomeCategoryListView()
                    default:
                        ItemGridView(menu)
                    }
                }
                
                HomeAdView()
                
                VStack(spacing: .zero) {
                    ItemMenuHeaderView(.popular)
                    DoubleColGrid(.popular)
                }
            }
        }
        .navigationBarTitle("Discover")
        .background(Color.groupedTableViewBackground)
        .confirmationAlert($appBackend.alert)
        .overlay(overlay)
//        .refreshableCompat(showsIndicators: false, onRefresh: appBackend.refreshAllData(_:), progress: { state in
//            ProgressView().opacity(state == .loading ? 1 : 0)
//        })
//
    }
    
    private var overlay: some View {
        Group {
            if isSearching {
                SearchView()
            }
        }
    }
}

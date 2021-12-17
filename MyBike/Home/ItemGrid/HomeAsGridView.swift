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
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false) {
                HomeImageCarousellView(itemViewModel: ItemViewModel(item: Item.mock()), geo: geo)
                ForEach(AppBackendManager.shared.homeMenus) { menu in
                    switch menu {
                    case .category:
                        HomeCategoryListView()
                    default:
                        ItemGridView(menu)
                    }
                }
                HomeAdView()
                VStack(spacing: .zero) {
                    ItemsHeaderView(.favourites)
                    DoubleColGrid(.suggessted)
                }
            }
            .navigationBarTitle("Discover")
            .overlay(isSearching ? SearchView().anyView : EmptyView().anyView)
            .refreshableCompat(showsIndicators: false, onRefresh: appBackend.refreshAllData(_:), progress: { state in
                ProgressView().opacity(state == .loading ? 1 : 0)
            })
            .confirmationAlert($appBackend.alert)
        }
    }
}

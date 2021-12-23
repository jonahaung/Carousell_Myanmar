//
//  BikeGridView.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import SwiftUI

struct Home_Grid_Section_Items: View {
    
    private let itemMenu: ItemMenu
    @StateObject private var datasource: ItemsDatasource
    
    init(_ _itemMenu: ItemMenu) {
        itemMenu = _itemMenu
        _datasource = StateObject(wrappedValue: AppBackendManager.shared.itemBackendManager(for: _itemMenu))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Item_Collection_Header(itemMenu)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 5) {
                    ForEach(datasource.itemViewModels) {
                        Item_Cell_Grid()
                            .environmentObject($0)
                    }
                    footer
                }
            }
            .insetGroupSectionStyle(padding: 7)
        }
        .padding(.top)
        .redacted(reason: !datasource.hasLoaded ? .placeholder : [])
        .task { datasource.fetchData() }
    }
    
    private var footer: some View {
        PagnitionProgressView(hasMoreData: $datasource.hasMoreData, isLoading: $datasource.isLoading) {
            datasource.loadData()
        } refresh: {
            datasource.resetData()
        }
    }
}

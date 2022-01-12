//
//  BikeGridView.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import SwiftUI

struct HomeItemSectionList: View {
    
    private let itemMenu: ItemMenu
    private var datasource: StateObject<ItemsDatasource>
    
    init(_ _itemMenu: ItemMenu) {
        itemMenu = _itemMenu
        datasource = StateObject(wrappedValue: AppBackendManager.shared.itemBackendManager(for: _itemMenu))
    }
    
    var body: some View {
        SectionWithItemTitleView(itemMenu) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 5) {
                    ForEach(datasource.wrappedValue.itemViewModels) {
                        Item_Cell_Grid()
                            .environmentObject($0)
                    }
                    if datasource.wrappedValue.hasLoaded {
                        PagnitionProgressView().environmentObject(datasource.wrappedValue)
                    }
                }
                .frame(height: PosterStyle.Size.medium.height)
                .task { await datasource.wrappedValue.fetchData() }
            }
            .insetGroupSectionStyle(padding: 5)
        }
    }
}

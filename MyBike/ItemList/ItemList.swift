//
//  ItemDoubleColumnGrid.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/12/21.
//

import SwiftUI

struct ItemList: View {
    
    private var gridItems: [GridItem] { UIScreen.main.bounds.size.width > 400 ? [.init(), .init(), .init()] : [.init(), .init()] }
    private let itemMenu: ItemMenu
    private var datasource: StateObject<ItemsDatasource>
    
    init(_ _itemMenu: ItemMenu) {
        itemMenu = _itemMenu
        datasource = StateObject(wrappedValue: AppBackendManager.shared.itemBackendManager(for: _itemMenu))
    }
    init(datasource: StateObject<ItemsDatasource>) {
        itemMenu = datasource.wrappedValue.itemMenu
        self.datasource = datasource
    }
    
    var body: some View {
        LazyVGrid(columns: gridItems) {
            ForEach(datasource.wrappedValue.itemViewModels) {
                ItemListCell()
                    .environmentObject($0)
            }
        }
        .insetGroupSectionStyle(padding: 7, innerPadding: 5)
        .task {
            await datasource.wrappedValue.fetchData()
        }
        if datasource.wrappedValue.hasLoaded {
            PagnitionProgressView().environmentObject(datasource.wrappedValue)
        }
    }
}

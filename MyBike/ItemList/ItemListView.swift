//
//  DoubleColGridView.swift
//  MyBike
//
//  Created by Aung Ko Min on 2/12/21.
//

import SwiftUI

struct ItemListView: View {
    
    private let itemMenu: ItemMenu
    private var datasource: StateObject<ItemsDatasource>
    
    init(_ _itemMenu: ItemMenu) {
        itemMenu = _itemMenu
        datasource = StateObject(wrappedValue: AppBackendManager.shared.itemBackendManager(for: _itemMenu))
    }

    var body: some View {
        CustomScrollView {
            ItemList(datasource: datasource)
        }
        .navigationTitle(itemMenu.title)
        .navigationBarItems(trailing: navTrailingView)
        .refreshable {
            await datasource.wrappedValue.resetData()
        }
    }
    
    private var navTrailingView: some View {
        HStack {
            let actionSheet = ActionSheet.sortActionSheet { sort in
                print(sort.title())
            }
            TapToShowActionSheetView(actionSheet: actionSheet, content: Text("Sort"))
        }
    }
}

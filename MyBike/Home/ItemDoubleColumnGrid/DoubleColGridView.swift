//
//  DoubleColGridView.swift
//  MyBike
//
//  Created by Aung Ko Min on 2/12/21.
//

import SwiftUI

struct DoubleColGridView: View {
    
    private let itemMenu: ItemMenu
    
    init(_ itemMenu: ItemMenu) {
        self.itemMenu = itemMenu
    }
    
    var body: some View {
        ScrollView {
            DoubleColGrid(itemMenu)
        }
        .navigationTitle(itemMenu.title)
        .background(Color.groupedTableViewBackground)
//        .refreshableCompat(onRefresh: { complete in
//            AppBackendManager.shared.itemBackendManager(for: itemMenu).resetData()
//            complete()
//        }, progress: { state in
//            ProgressView().opacity(state == .loading || state == .primed ? 1 : 0)
//        })
    }
}

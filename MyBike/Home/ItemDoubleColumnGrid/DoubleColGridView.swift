//
//  DoubleColGridView.swift
//  MyBike
//
//  Created by Aung Ko Min on 2/12/21.
//

import SwiftUI

struct DoubleColGridView: View {
    
    private let itemMenu: ItemMenu
    @EnvironmentObject var appBackend: AppBackendManager
    
    init(_ itemMenu: ItemMenu) {
        self.itemMenu = itemMenu
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            DoubleColGrid(itemMenu)
        }
        .navigationTitle(itemMenu.title)
        .refreshableCompat(onRefresh: { complete in
            appBackend.itemBackendManager(for: itemMenu).resetData()
            complete()
        }, progress: { state in
            ProgressView().opacity(state == .loading || state == .primed ? 1 : 0)
        })
    }
}

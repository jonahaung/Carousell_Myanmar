//
//  BikeGridView.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import SwiftUI

struct ItemGridView: View {
    
    private let itemMenu: ItemMenu
    @StateObject private var datasource: ItemsDatasource
    
    init(_ _itemMenu: ItemMenu) {
        itemMenu = _itemMenu
        _datasource = StateObject(wrappedValue: AppBackendManager.shared.itemBackendManager(for: _itemMenu))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ItemMenuHeaderView(itemMenu)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 5) {
                    ForEach(datasource.itemViewModels) {
                        ItemGridCell()
                            .environmentObject($0)
                    }
                    footer
                }
            }
            .insetGroupSectionStyle(7)
        }
        .padding(.top)
        .redacted(reason: !datasource.hasLoaded ? .placeholder : [])
        .confirmationAlert($datasource.errorAlert)
        .task { datasource.fetchData() }
    }
    
    private var footer: some View {
        Group {
            if datasource.hasLoaded && datasource.hasMoreData {
                PagnitionProgressView {
                    datasource.loadData()
                }
            }else {
                Text("\(datasource.itemViewModels.count)").foregroundColor(.secondary).padding()
            }
        }
    }
}

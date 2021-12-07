//
//  ItemDoubleColumnGrid.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/12/21.
//

import SwiftUI

struct DoubleColGrid: View {
    
    private let itemMenu: ItemMenu
    @StateObject private var datasource: ItemsDatasource
    @Environment(\.isSearching) private var isSearching
    
    init(_ itemMenu: ItemMenu) {
        self.itemMenu = itemMenu
        _datasource = StateObject(wrappedValue: AppBackendManager.shared.itemBackendManager(for: itemMenu))
    }
    
    private var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: threeColumnGrid) {
            ForEach(datasource.itemViewModels) { itemViewModel in
                DoubleColGridCell(itemViewModel: itemViewModel)
            }
            SingleAxisGeometryReader { width in
                footer
                    .frame(width: width, height: width * 1.5, alignment: .center)
            }
        }
        .insetGroupSectionStyle(10)
        .redacted(reason: !datasource.hasLoaded ? .placeholder : [])
        .alert(item: $datasource.errorAlert) { Alert(alertObject: $0) }
        .task {
            datasource.loadData()
        }
        .overlay(isSearching ? SearchView().anyView : EmptyView().anyView)
    }
    
    private var footer: some View {
        Group {
            if datasource.hasMoreData {
                 PagnitionProgressView {
                    datasource.loadData()
                }
            }else {
                Text("\(datasource.itemViewModels.count) items")
            }
        }
    }
}

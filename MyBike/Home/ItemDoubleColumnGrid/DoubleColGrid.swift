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
    
    init(_ _itemMenu: ItemMenu) {
        itemMenu = _itemMenu
        _datasource = StateObject(wrappedValue: AppBackendManager.shared.itemBackendManager(for: _itemMenu))
    }
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: twoColumnGrid) {
            ForEach(datasource.itemViewModels) {
                DoubleColGridCell(itemViewModel: $0)
            }
            SingleAxisGeometryReader { width in
                footer
                    .frame(minWidth: width, minHeight: width * PosterStyle.aspectRatio)
            }
            
            
        }
        .overlay(isSearching ? SearchView().anyView : EmptyView().anyView)
        .insetGroupSectionStyle(10)
        .foregroundStyle(.primary)
        .redacted(reason: !datasource.hasLoaded ? .placeholder : [])
        .confirmationAlert($datasource.errorAlert)
        .task {
            datasource.loadData()
        }
    }
    
    private var footer: some View {
        Group {
            if datasource.hasMoreData {
                PagnitionProgressView {
                    datasource.loadData()
                }.onTapGesture {
                    datasource.loadData()
                }
            }else {
                Text("\(datasource.itemViewModels.count) items").italic().foregroundColor(.tertiaryLabel)
            }
        }
    }
}

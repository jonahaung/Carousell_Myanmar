//
//  BikeListView.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import SwiftUI
import Combine

struct ItemListView: View {
    
    let itemMenu: ItemMenu
    @StateObject private var datasource: ItemsDatasource
    
    init(_ itemMenu: ItemMenu) {
        self.itemMenu = itemMenu
        _datasource = StateObject(wrappedValue: ItemsDatasource(itemMenu))
    }
    var body: some View {
        List {
            Section(footer: footer) {
                ForEach(datasource.itemViewModels) {
                    ItemListCell(itemViewModel: $0)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle(datasource.itemMenu.title())
        .alert(item: $datasource.errorAlert) { Alert(alertObject: $0) }
        .redacted(reason: !datasource.hasLoaded ? .placeholder : [])
        .refreshable { datasource.resetData() }
        .task { datasource.fetchData() }
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

//
//  BikeGridView.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import SwiftUI

struct ItemGridView: View {
    
    let itemMenu: ItemMenu
    @StateObject private var datasource: ItemsDatasource
    
    init(_ itemMenu: ItemMenu) {
        self.itemMenu = itemMenu
        _datasource = StateObject(wrappedValue: AppBackendManager.shared.itemBackendManager(for: itemMenu))
    }
    
    var body: some View {
        VStack(spacing: 8) {
            header(for: datasource.itemMenu)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 10) {
                    ForEach(datasource.itemViewModels) {
                        ItemGridCell(itemViewModel: $0)
                    }
                    footer
                }
            }
        }
        .padding(.leading, 5)
        .plainGroupSectionStyle()
        .redacted(reason: !datasource.hasLoaded ? .placeholder : [])
        .alert(item: $datasource.errorAlert) { Alert(alertObject: $0) }
        .task { datasource.fetchData() }
    }
    private func header(for menu: ItemMenu) -> some View {
        HStack {
            Text(menu.title())
                .textStyle(style: .title_title)
                .foregroundColor(.steam_gold)
            Spacer()
            Text("See all")
                .tapToPushItemsList(menu)
        }
        .padding(.horizontal)
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

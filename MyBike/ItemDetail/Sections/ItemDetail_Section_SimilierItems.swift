//
//  ItemsGridsSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/12/21.
//

import SwiftUI

struct ItemDetail_Section_SimilierItems: View {
    
    private let itemMenu: ItemMenu
    @StateObject private var datasource: ItemsDatasource
    
    init(_ itemMenu: ItemMenu){
        _datasource = StateObject(wrappedValue: AppBackendManager.shared.itemBackendManager(for: itemMenu))
        self.itemMenu = itemMenu
    }
    

    var body: some View {
        SectionWithItemTitleView(itemMenu) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(datasource.itemViewModels) {
                        Item_Cell_Grid()
                            .environmentObject($0)
                    }
                }
            }
            .insetGroupSectionStyle()
        }
        .task {
            await datasource.fetchData()
        }
    }
}

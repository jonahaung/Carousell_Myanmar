//
//  ItemsGridsSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/12/21.
//

import SwiftUI

struct ItemsGridsSection: View {
    
    @ObservedObject private var itemViewModel: ItemViewModel
    @ObservedObject private var datasource: ItemsDatasource
    private let posterSize: PosterStyle.Size
    
    init(_ itemViewModel: ItemViewModel, _ itemMenu: ItemMenu, _ posterSize: PosterStyle.Size){
        self.itemViewModel = itemViewModel
        datasource = AppBackendManager.shared.itemBackendManager(for: itemMenu)
        self.posterSize = posterSize
    }
    

    var body: some View {
        
        VStack(alignment: .leading) {
            ItemsHeaderView(datasource.itemMenu)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(datasource.itemViewModels) {
                        ItemGridCell(itemViewModel: $0)
                    }
                }
            }.insetGroupSectionStyle()
        }
        .task { datasource.loadData()}
    }
}

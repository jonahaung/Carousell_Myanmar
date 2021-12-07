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
    
    private var rows: [GridItem] { return [
        GridItem(.adaptive(minimum: posterSize.width)),
        GridItem(.adaptive(minimum: posterSize.width))
    ]}
    
    var body: some View {
        
        VStack(alignment: .leading) {
            header(for: datasource.itemMenu)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(datasource.itemViewModels) {
                        ItemImageView($0.item.images.firstImage, posterSize)
                            .cornerRadius(10)
                            .tapToPush(ItemDetailView(itemViewModel: itemViewModel).anyView)
                    }
                }
            }
        }
        .plainGroupSectionStyle()
        .task {
            datasource.loadData()
        }
    }
    
    private func header(for menu: ItemMenu) -> some View {
        HStack {
            Text(menu.title())
            Spacer()
            Text("See all")
                .textStyle(style: .link_regular)
                .tapToPushItemsList(menu)
        }
        .padding(.horizontal)
    }
}

//
//  ItemDoubleColumnGrid.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/12/21.
//

import SwiftUI

struct DoubleCol_Grid: View {
    
    @EnvironmentObject private var datasource: ItemsDatasource
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        Group {
            LazyVGrid(columns: twoColumnGrid) {
                ForEach(datasource.itemViewModels) { vm in
                    Item_Cell_DoubleColumn()
                        .environmentObject(vm)
                }
            }
            .insetGroupSectionStyle()
            .redacted(reason: !datasource.hasLoaded ? .placeholder : [])
            .task {
                datasource.fetchData()
            }
            if datasource.hasLoaded {
                progressView
            }
        }
    }
    
    private var progressView: some View {
        PagnitionProgressView(hasMoreData: $datasource.hasMoreData, isLoading: $datasource.isLoading) {
            datasource.loadData()
        } refresh: {
            datasource.resetData()
        }
    }
}

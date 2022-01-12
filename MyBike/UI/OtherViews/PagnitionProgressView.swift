//
//  PagnitionProgressView.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/11/21.
//

import SwiftUI

struct PagnitionProgressView: View {
    
    @EnvironmentObject private var datasource: ItemsDatasource
    
    var body: some View {
        ZStack {
            if datasource.hasMoreData {
                if datasource.isLoading {
                    ProgressView("loading")
                }else {
                    ProgressView("preparing")
                        .task {
                            await datasource.loadMoreIfNeeded()
                        }
                }
            } else {
                Text("\(datasource.itemViewModels.count) items loaded")
                    
            }
        }
        .font(.subheadline)
        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
    }
}

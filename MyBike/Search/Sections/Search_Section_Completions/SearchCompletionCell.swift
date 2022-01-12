//
//  SearchCompletionCell.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/1/22.
//

import SwiftUI

struct SearchCompletionCell: View {
    
    @EnvironmentObject private var searchManager: SearchViewManager
    @EnvironmentObject private var authenticationService: AuthenticationService
    var item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(item.seller.userName).italic()
                Spacer()
                Text(item.condition.description)
                Spacer()
                Text(item.dateAdded.relativeString)
            }
            .font(.FHACondFrenchNC(13)).foregroundStyle(.secondary)
            
            Text(item.title.capitalized).fontWeight(.semibold)
            
            HStack {
                Text(item.category.title)
                Spacer()
                Text(item.address.township)
                Spacer()
                Text(item.views.count.description + "views")
            }
            .font(.FHACondFrenchNC(13))
            .foregroundStyle(.tertiary)
        }.onTapGesture {
            Task {
                await searchManager.search(.search([.Title(.Full(title: item.title))]))
                
            }
            searchManager.searchText = item.title.capitalized
            if let currentUserViewModel = authenticationService.currentUserViewModel {
                currentUserViewModel.setAction(.updateHistory(.searchWords(item.title), .Add))
            }
        }
    }
}

//
//  Search_Section_Completions.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/1/22.
//

import SwiftUI

struct Search_Section_Completions: View {
    
    @EnvironmentObject private var searchManager: SearchViewManager
    
    var body: some View {
        Section {
            ForEach(searchManager.completionResults) {
                SearchCompletionCell(item: $0)
            }
            filterTagsView
        }
    }
    
    private var filterTagsView: some View {
        Group {
            if !searchManager.searchContext.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        if searchManager.searchContext.category.isSelected {
                            Text(searchManager.searchContext.category.title)
                                .modifier(BorderedTextModifier(color: .secondary))
                        }
                        if !searchManager.searchContext.address.isEmpty {
                            Text(searchManager.searchContext.address.state)
                                .modifier(BorderedTextModifier(color: .secondary))
                        }
                        if searchManager.searchContext.condition.isSelected {
                            Text(searchManager.searchContext.condition.description)
                                .modifier(BorderedTextModifier(color: .secondary))
                        }
                    }
                }
                .font(.footnote)
            }
        }
    }
}

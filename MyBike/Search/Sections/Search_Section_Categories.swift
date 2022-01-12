//
//  Search_Section_Categories.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/1/22.
//

import SwiftUI

struct Search_Section_Categories: View {
    
    @EnvironmentObject private var searchManager: SearchViewManager
    
    var body: some View {
        let categories = Category.allValues.filter{ $0.title.contains(searchManager.searchText)}
        if !categories.isEmpty {
            Section("Cagegories") {
                ForEach(categories) { category in
                    Text(category.title.capitalized).fontWeight(.medium).badge(category.parentNode?.title ?? "")
                        .onTapGesture {
                            searchManager.searchContext.category = category
                            searchManager.objectWillChange.send()
//                            Task {{
//                                await searchManager.search(.search([.Category(category)]))
//                            }}
//                            searchManager.searchText = category.title.capitalized
                        }.foregroundColor(.accentColor)
                }
            }
        }
    }
}

struct Search_Section_Categories_Previews: PreviewProvider {
    static var previews: some View {
        Search_Section_Categories()
    }
}

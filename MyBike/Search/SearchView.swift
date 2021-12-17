//
//  HomeSearchView.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/11/21.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var searchManager: SearchViewManager
    
    var body: some View {
        List {
            if searchManager.searchText.isEmpty {
                Section {
                    HStack {
                        Text("Category")
                        Spacer()
                        Text(searchManager.category.title).tapToPresent(NavigationView{CategoryPickerView(category: $searchManager.category)}.anyView, false)
                    }
                    filterMenu
                }
            }
            
            if !searchManager.completionResults.isEmpty {
                Section("Results") {
                    ForEach(searchManager.completionResults) { vm in
                        SearchCompletionCell(itemViewModel: vm)
                            .onTapGesture {
                                searchManager.search(.search([.Title(vm.item.title)]))
                                searchManager.searchText = vm.item.title.capitalized
                            }
                    }
                }
            }
            
            if !searchManager.categories.isEmpty {
                Section("Categories") {
                    ForEach(searchManager.categories) { category in
                        Text(category.title.capitalized).fontWeight(.medium).badge(category.parentNode?.title ?? "").onTapGesture {
                            searchManager.search(.search([.Category(category)]))
                            searchManager.searchText = category.title.capitalized
                        }
                    }
                }
            }
            
            Section {
                ForEach(searchManager.finalResults) {
                    SearchResultCell(itemViewModel: $0)
                }
            }
        }
        .refreshable {
            searchManager.searchText = String()
        }
    }
    
    private var filterMenu: some View {
        Picker("Filter", selection: $searchManager.searchMenu) {
            ForEach(SearchViewManager.SearchMenu.allCases) { menu in
                Text("\(menu.rawValue)").tag(menu)
            }
        }.pickerStyle(.menu)
    }
}

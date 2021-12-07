//
//  HomeSearchView.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/11/21.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var searchManager: SearchViewManager
    
    enum SheetType: Identifiable {
        var id: SheetType { return self }
        case categoryPicker
    }
    
    @State private var sheetType: SheetType?
    
    var body: some View {
        List {
            if searchManager.searchText.isEmpty {
                Section {
                    Text("Category")
                        .badge(searchManager.category.title)
                        .onTapGesture {
                            sheetType = .categoryPicker
                        }
                    filterMenu
                }
            }
            
            Section {
                ForEach(searchManager.searchResults) { itemViewModel in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(itemViewModel.item.title.capitalized)
                                .textStyle(style: .title_regular)
                            Spacer()
                            Text(itemViewModel.item.seller.userName)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        HStack{
                            Text(itemViewModel.item.category.title)
                                .textStyle(style: .link_small)
                                .foregroundColor(.secondary)
                        }
                            
                    }
                    .padding(.vertical, 5)
                    .tapToPush(ItemDetailView(itemViewModel: itemViewModel).anyView)
                    .accentColor(.primary)
                }
            }
        }
        .sheet(item: $sheetType, content: { type in
            switch type {
            case .categoryPicker:
                CategoryPickerView(category: $searchManager.category)
            }
        })
    }
    
    private var filterMenu: some View {
        Picker("", selection: $searchManager.searchFilter) {
            ForEach(SearchViewManager.SearchFilter.allCases) { filter in
                Text("\(filter.rawValue)").tag(filter)
            }
        }.pickerStyle(.segmented)
    }
}

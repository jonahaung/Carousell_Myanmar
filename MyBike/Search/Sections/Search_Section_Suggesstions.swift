//
//  SearchSuggesstionsView.swift
//  MyBike
//
//  Created by Aung Ko Min on 25/12/21.
//

import SwiftUI

struct Search_Section_Suggesstions: View {
    
    @EnvironmentObject private var authenticationService: AuthenticationService
    @EnvironmentObject private var searchManager: SearchViewManager
    
    var body: some View {
        if searchManager.showFilters {
            Section(header: filterFooter) {
                category
                address
                condition
                objectTypeMenu
                searchTypeMenu
            }
        } else {
            Section(header: historyHeader) {
                if let words = authenticationService.currentUserViewModel?.person.viewedHistory.searchedWords {
                    ForEach(words, id: \.self) { string in
                        let string = string.capitalized
                        Text(string)
                            .italic()
                            .onTapGesture {
                                searchManager.searchText = string
                            }
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
    
    private var historyHeader: some View {
        HStack {
            Text("History")
            Spacer()
            Button("Filters", action: toggleFilter)
        }
    }
    
    private var filterFooter: some View {
        HStack {
            Button("Close", action: toggleFilter)
            Spacer()
            Button("Reset", action: searchManager.resetAll).disabled(searchManager.searchContext.isEmpty)
        }.accentColor(.pink)
    }
    private var category: some View {
        FormCell("Category") {
            Text(searchManager.searchContext.category.title)
                .foregroundStyle(searchManager.searchContext.category.isSelected ? .primary : .quaternary)
            
                .tapToPresentWithPresentationMode { isPresented in
                    CategoryPickerView(category: $searchManager.searchContext.category) {
                        isPresented.wrappedValue = false
                        searchManager.searchContext.category = $0
                       
                    }
                } onAppear: {
                    holdSearchField()
                } onDismiss: {
                    releaseSearchField()
                }
        }
    }
    
    private var condition: some View {
        
        FormCell("Condition") {
            Text(searchManager.searchContext.condition.description)
                .foregroundStyle(searchManager.searchContext.condition.isSelected ? .primary : .quaternary)
                .tapToPresentWithPresentationMode { isPresented in
                    CustomPicker(Item.Condition.allCases, searchManager.searchContext.condition) {
                        isPresented.wrappedValue = false
                        searchManager.searchContext.condition = $0
                    }
                } onAppear: {
                    holdSearchField()
                } onDismiss: {
                    releaseSearchField()
                }
        }
    }
    private var address: some View {
        FormCell("Region") {
            HStack{
                Text(searchManager.searchContext.address.township)
                Text(searchManager.searchContext.address.state).underline()
            }
            .foregroundStyle(!searchManager.searchContext.address.isEmpty ? .primary : .quaternary)
            .tapToPresentWithPresentationMode { isPresented in
                RegionPicker(address: searchManager.searchContext.address) {
                    searchManager.searchContext.address = $0
                    isPresented.wrappedValue = false
                }
            } onAppear: {
                holdSearchField()
            } onDismiss: {
                releaseSearchField()
            }
        }
    }
    
    private var objectTypeMenu: some View {
        Picker("", selection: $searchManager.searchContext.searchObjectType) {
            ForEach(SearchObjectType.allCases, id: \.self) { type in
                Text(type.title).tag(type)
            }
        }
        .pickerStyle(.segmented)
        .labelsHidden()
    }
    
    private var searchTypeMenu: some View {
        Picker("", selection: $searchManager.searchContext.searchTextType) {
            ForEach(SearchTextType.allCases, id: \.self) { type in
                Text(type.description).tag(type)
            }
        }
        .pickerStyle(.segmented)
        .labelsHidden()
    }
    
    
    
    private func holdSearchField() {
        searchManager.searchText = "@"
    }
    private func releaseSearchField() {
        searchManager.searchText = ""
    }
    
    private func toggleFilter() {
        withAnimation(.interactiveSpring()) {
            searchManager.showFilters.toggle()
            searchManager.objectWillChange.send()
        }
    }
}

//
//  ViewedHistoryView.swift
//  MyBike
//
//  Created by Aung Ko Min on 31/12/21.
//

import SwiftUI

struct ViewedHistoryView: View {
    
    @EnvironmentObject private var currentUserViewModel: CurrentUserViewModel
    @State private var selectedSection = Person.ViewedHistory.ViewedHistoryType.category(Category.none)
    
    var body: some View {
    
        List {
            Section(header: historyTypePicker) {
                
            }
            if let viewedHistory = currentUserViewModel.person.viewedHistory {
                Section {
                    switch selectedSection {
                    case .category(_):
                        ForEach(viewedHistory.categories) {
                            Text($0.title).badge($0.parentNode?.title ?? "")
                        }
                        .onDelete(perform: deleteCategory)
                    case .searchWords(_):
                        ForEach(viewedHistory.searchedWords) {
                            Text($0)
                        }
                        .onDelete(perform: deleteSearchWords)
                    }
                }
            }
        }
        .navigationTitle("Viewed History")
        .navigationBarItems(trailing: trailingItems)
    }
    
    private var historyTypePicker: some View {
        Picker("", selection: $selectedSection) {
            ForEach(Person.ViewedHistory.ViewedHistoryType.allCases, id: \.self) { type in
                Text(type.title).tag(type)
            }
        }
        .pickerStyle(.segmented)
    }
    
    private var trailingItems: some View {
        HStack {
            Button("Delete All") {
                currentUserViewModel.setAction(.updateHistory(.category(.none), .RemoveAll))
            }
            EditButton()
        }
    }
    
    private func deleteCategory(at offsets: IndexSet) {
        let viewedHistory = currentUserViewModel.person.viewedHistory
        let categories = offsets.map{ viewedHistory.categories[$0] }
        
        categories.forEach { category in
            currentUserViewModel.setAction(.updateHistory(.category(category), .Delete))
        }
    }
    
    private func deleteSearchWords(at offsets: IndexSet) {
        let viewedHistory = currentUserViewModel.person.viewedHistory
        let texts = offsets.map{ viewedHistory.searchedWords[$0] }
        texts.forEach { text in
            currentUserViewModel.setAction(.updateHistory(.searchWords(text), .Delete))
        }
    }
}

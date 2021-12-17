//
//  CategoryPickerView.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/11/21.
//

import SwiftUI

struct CategoryPickerView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Binding var category: Category
    
    var body: some View {
        List {
            OutlineGroup(Category.categories, children: \.children) { category in
                if category.children == nil {
                    Text(category.title).foregroundColor(.secondary)
                        .onTapGesture {
                            self.category = category
                            presentationMode.wrappedValue.dismiss()
                        }
                        .disabled(category == self.category)
                } else {
                    Text(category.title)
                }
            }
        }
        .listStyle(.insetGrouped)
        .textStyle(style: .title_regular)
        .navigationTitle("Categories")
    }
    
    private func cancel() {
        presentationMode.wrappedValue.dismiss()
    }
}

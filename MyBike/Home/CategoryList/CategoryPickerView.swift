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
    var onPick: ((Category) -> Void)? = nil
    
    var body: some View {
        List {
            OutlineGroup(Category.categories, children: \.children) { category in
                if category.children == nil {
                    Text(category.title).foregroundColor(.secondary)
                        .onTapGesture {
                            self.category = category
                            if let onPick = onPick {
                                onPick(category)
                            }
                            presentationMode.wrappedValue.dismiss()
                        }
                } else {
                    Text(category.title)
                }
            }
        }
        .navigationTitle("Categories")
    }

}

//
//  HomeCategoryListView.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/12/21.
//

import SwiftUI

struct HomeCategoryView: View {
    
    @State private var topExpanded: Bool = false
    @State private var currentSelected: Category?
    
    var body: some View {
        SectionWithTitleView("Categories") {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Category.categories) {
                    CategoryCell(category: $0, selectedCategory: $currentSelected)
                }
            }
            .insetGroupSectionStyle(padding: 10)
        }
    }
}

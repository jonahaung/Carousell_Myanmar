//
//  HomeCategoryListView.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/12/21.
//

import SwiftUI

struct HomeCategoryListView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ItemMenuHeaderView.init(.category, _showSeeAll: false)
            OutlineGroup(Category.categories, children: \.children) { category in
                VStack(alignment: .leading, spacing: 0) {
                    Group{
                        if category.children == nil {
                            Text(category.title)
                                .tapToPushItemsList(.search([.Category(category)]))
                                .foregroundColor(.secondary)
                        } else {
                            Text(category.title)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(.vertical, 4)
                    Divider()
                        .hidden()
                }
                .padding(.leading, getSpaceFor(category))
            }
            .insetGroupSectionStyle()
            .font(.system(size: UIFont.labelFontSize, weight: .semibold, design: .serif))
        }
    }
    
    private func getSpaceFor(_ catelogy: Category) -> CGFloat {
        var space = -20.00
        var catelogy = catelogy
        
        while let parent = catelogy.parentNode {
            catelogy = parent
            space += 30
        }
        return space
    }
    
}

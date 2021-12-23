//
//  HomeCategoryListView.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/12/21.
//

import SwiftUI

struct Home_Grid_Section_Category: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Item_Collection_Header.init(.category, _showSeeAll: false)
            
            OutlineGroup(Category.categories, children: \.children) { category in
                Group{
                    if category.children == nil {
                        HStack {
                            Text(category.title)
                            Spacer()
                        }
                        .tapToPushItemsList(.search([.Category(category)]))
                    } else {
                        Text(category.title)
                            .font(.Serif())
                            .fontWeight(.bold)
                    }
                }
                .foregroundColor(.primary)
                .padding(.bottom, 5)
                .padding(.leading, getSpaceFor(category))
            }
            .insetGroupSectionStyle(innerPadding: 15)
        }
    }
    
    private func getSpaceFor(_ catelogy: Category) -> CGFloat {
        var space = -30.0
        var catelogy = catelogy
        while let parent = catelogy.parentNode {
            catelogy = parent
            space += 30
        }
        return space
    }
}

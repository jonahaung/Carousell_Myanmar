//
//  CategoryCell.swift
//  MyBike
//
//  Created by Aung Ko Min on 9/1/22.
//

import SwiftUI

struct CategoryCell: View {
    
    let category: Category
    @Binding var selectedCategory: Category?
    
    @State private var isExpended = false
    
    var body: some View {
        Group {
            if let children = category.children {
                DisclosureGroup(isExpanded: $isExpended) {
                    ForEach(children) {
                        CategoryCell(category: $0, selectedCategory: $selectedCategory)
                    }
                } label: {
                    cellBody
                }
            } else {
                cellBody
                    .padding(.bottom, 2)
                    .tapToPushItemsList(.search([.Category(category)]))
            }
        }
        .onChange(of: isExpended) { newValue in
            if newValue && category.isTopItem {
                Vibration.rigid.vibrate()
                selectedCategory = category
            }
        }
        .onChange(of: selectedCategory) { newValue in
            if category.isTopItem && newValue != category && isExpended {
                withAnimation {
                    isExpended = false
                }
            }
        }
    }
    
    private var cellBody: some View {
        HStack {
            if category.children != nil {
                Text(category.title)
            } else {
                Image(systemName: "magnifyingglass")
                    .imageScale(.small)
                    .foregroundColor(.accentColor)
                Text(category.title)
            }
            Spacer()
        }
        .font(.FjallaOne(UIFont.buttonFontSize))
        .padding(.leading, getSpaceFor(category))
        .foregroundColor(category.hasChildren ? .primary : .secondary)
    }
    
    private func getSpaceFor(_ catelogy: Category) -> CGFloat {
        var space = -20.0
        var catelogy = catelogy
        while let parent = catelogy.parentNode {
            catelogy = parent
            space += 20
        }
        return space
    }
}

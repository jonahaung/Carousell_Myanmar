//
//  CategoryList.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import SwiftUI

struct CategoryList: View {
    
    @EnvironmentObject var appBackendManager: AppBackendManager
    
    var body: some View {
        OutlineGroup(Category.categories, children: \.children) { category in
            if category.children == nil {
                Text(category.title) .foregroundColor(.secondary)
                    .tapToPushItemsList(.search(.Category(category)))
            } else {
                Text(category.title)
            }
        }
        .textStyle(style: .title_regular)
    }
    
}

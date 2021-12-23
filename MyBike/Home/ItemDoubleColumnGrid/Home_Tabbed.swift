//
//  HomeAsListView.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/11/21.
//

import SwiftUI

struct Home_Tabbed: View {
    
    @State private var selectedMenu = ItemMenu.suggessted
    
    var body: some View {
        TabView(selection: $selectedMenu) {
            ForEach(ItemMenu.homeMenus) { menu in
                Group {
                    switch menu {
                    case .category:
                        List {
                            CategoryList()
                        }
                    default:
                        DoubleCol_Scroll(menu)
                    }
                }
                .tag(menu)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

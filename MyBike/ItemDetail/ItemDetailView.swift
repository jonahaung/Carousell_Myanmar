//
//  BikeDetailView.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/11/21.
//

import SwiftUI

struct ItemDetailView: View {
    
    @EnvironmentObject private var itemViewModel: ItemViewModel
    @EnvironmentObject private var authService: AuthenticationService
    
    var body: some View {
        CustomScrollView {
            ItemDetail_Section_Images()
            ItemDetail_Section_One()
            ItemDetail_Section_Keywords()
            ItemDetail_Section_Two()
            ItemDetail_Section_Seller()
            ItemDetail_Section_Location()
            ItemDetail_Section_Buy()
            ItemDetail_Section_SimilierItems(.search([.Person(uid: itemViewModel.item.seller.id)]))
            
            let itemMenu = ItemMenu.search([.Category(itemViewModel.item.category)])
            SectionWithItemTitleView(itemMenu) {
                ItemList(itemMenu)
            }
        }
        .navigationTitle("Detail")
        .navigationBarItems(trailing: navTrailingView)
        .task {
            if let currentUserViewModel = authService.currentUserViewModel {
                itemViewModel.setAction(.setHasViewed(currentUserViewModel))
                itemViewModel.setAction(.updateCurrentUser(currentUserViewModel))
            }
        }
    }
    
    private var navTrailingView: some View {
        HStack {
            if itemViewModel.item.seller.isOwner {
                let actionSheet = ActionSheet.itemDetailOwnerMenuActionSheet(itemViewModel) {
                    itemViewModel.setAction(.ownerAction($0))
                }
                TapToShowActionSheetView(actionSheet: actionSheet, content: Text("Edit"))
            }
        }
    }
}

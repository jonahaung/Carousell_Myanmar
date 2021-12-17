//
//  ItemCommentsView.swift
//  MyBike
//
//  Created by Aung Ko Min on 25/11/21.
//

import SwiftUI

struct ItemCommentsView: View {
    
    @StateObject var itemViewModel: ItemViewModel
    @State private var showCommentWritter = false
    @EnvironmentObject var authenticationService: AuthenticationService
    
    var body: some View {
        List{
            ForEach(itemViewModel.item.comments.sorted{ $0.date > $1.date }) { comment in
                Section{
                    CommentRow(comment: comment)
                }
            }
            
        }
        .navigationBarTitle(Text("Comments"))
        .navigationBarItems(trailing: navTrailing)
        
    }
    
    private var navTrailing: some View {
        HStack {
            Text("Write")
                .tapToPresent(CommentWriterView(itemViewModel: itemViewModel)
                                .environmentObject(authenticationService).anyView, false)
        }
    }
}

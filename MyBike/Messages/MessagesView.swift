//
//  MessagesView.swift
//  MyBike
//
//  Created by Aung Ko Min on 7/12/21.
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        NavigationView {
            ScrollView{
                Text("Hello")
            }
            .background(Color.groupedTableViewBackground)
                .navigationTitle("Notifications")
        }
        .navigationViewStyle(.stack)
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}

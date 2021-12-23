//
//  SwiftUIView.swift
//  MyBike
//
//  Created by Aung Ko Min on 25/11/21.
//

import SwiftUI

struct Item_Details_Row_Comments: View {
    
    let comment: Item.Comment
    
    var body: some View {
        Section(header: header) {
            Text(comment.text)
                .font(.body)
                .lineLimit(nil)
                .foregroundColor(.secondary)
        }
    }
    var header: some View {
        Group{
            Text(comment.person.userName)
                .font(.subheadline)
                .fontWeight(.bold)
            +
            Text(" " + comment.date.relativeString)
                .font(.subheadline)
                .foregroundColor(.tertiaryLabel)
        }
        .tapToPush(Text("User Profile").anyView)
    }
}

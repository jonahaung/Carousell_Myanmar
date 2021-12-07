//
//  CommentWriterView.swift
//  MyBike
//
//  Created by Aung Ko Min on 25/11/21.
//

import SwiftUI

struct CommentWriterView: View {
    
    @StateObject var itemViewModel: ItemViewModel
    
    @EnvironmentObject var authenticationService: AuthenticationService
    @Environment(\.presentationMode) var presentationMode

    @State private var text = ""
    
    
    var body: some View {
        Group {
            GeometryReader { geo in
                Form {
                    Section("Type message") {
                        DynamicHeightTextView(text: $text)
                            .frame(minHeight: geo.frame(in: .global).size.width/2)
                            
                        submitButton
                    }
                }
            }
        }
    }
    
    private var submitButton: some View {
        Button {
            if !text.isEmpty, let person = authenticationService.person {
                let comment = Item.Comment(text, person)
                itemViewModel.addComments(comment: comment) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        } label: {
            Text("Submit")
                .formSubmitButtonStyle(.accentColor)
        }
        .disabled(text.isEmpty)
    }
}

//
//  CommentWriterView.swift
//  MyBike
//
//  Created by Aung Ko Min on 25/11/21.
//

import SwiftUI

struct Item_Details_Comments_Writer: View {
    
    @StateObject var itemViewModel: ItemViewModel
    
    @EnvironmentObject var authenticationService: AuthenticationService
    @Environment(\.presentationMode) var presentationMode

    @State private var text = ""
    
    
    var body: some View {
        VStack {
            Spacer()
            Form {
                Section("Type message"){
                    TextEditor(text: $text)
                    
                    submitButton
                }
            }
        }
        .foregroundStyle(.primary)
    }
    
    private var submitButton: some View {
        Button {
            if !text.isEmpty, let person = authenticationService.currentUserViewModel?.person {
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

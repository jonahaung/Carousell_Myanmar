//
//  SignInView.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/12/21.
//

import SwiftUI

struct SignInView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Sign In with Email")
                    .tapToPush(SignInWithEmailView(presentationMode))
            }
            .navigationTitle("Sign In")
            .navigationBarItems(trailing: navTrailingView)
        }
    }
    
    private var navTrailingView: some View {
        HStack {
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

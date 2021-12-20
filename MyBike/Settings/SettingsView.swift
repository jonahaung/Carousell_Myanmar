//
//  SettingsView.swift
//  MyBike
//
//  Created by Aung Ko Min on 12/9/21.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ScrollView{
                Text("Hello")
            }
            .background(Color.groupedTableViewBackground)
            .navigationTitle("Settings")
        }
        .navigationViewStyle(.stack)
    }
}

//
//  SettingsView.swift
//  MyBike
//
//  Created by Aung Ko Min on 12/9/21.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView{
            DatePicker("", selection: .constant(Date()))
                .pickerStyle(.automatic)
                .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

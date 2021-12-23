//
//  SettingsView.swift
//  MyBike
//
//  Created by Aung Ko Min on 12/9/21.
//

import SwiftUI

struct AppSettingsView: View {
    
    @EnvironmentObject private var viewRouter: ViewRouter
    @StateObject private var manager = AppSettingsViewManager()
    
    var body: some View {
        Form {
            Section {
                homeModeRow
                openDeveiceSettingsRow
                shareAppRow
                privacyPolicyRow
                rateOnAppView
            }
            
            Section {
                cachedItemsRow
            }
        }
        .navigationTitle("Settings")
    }
}


extension AppSettingsView {
    
    private var cachedItemsRow: some View {
        Toggle("Is Cached", isOn: $manager.isCachedItem)
    }
    
    private var privacyPolicyRow: some View {
        Button("Privacy Policy Website") { manager.gotoPrivacyPolicy() }
    }
    
    private var homeModeRow: some View {
        Picker("Home Mode", selection: $viewRouter.homeViewMode) {
            ForEach(ViewRouter.HomeMode.allCases, id: \.self) { x in
                Text(x.description)
            }
        }
    }
    
    private var openDeveiceSettingsRow: some View {
        Button("Open Device Settings") { manager.gotoDeviceSettings() }
    }
    
    private var shareAppRow: some View {
        let url = URL(string: "https://apps.apple.com/us/app/bmcamera/id1560405807")!
        return Text("Share")
            .tapToPresent(ActivityView(activityItems: [url]).anyView, false)
    }
    private var rateOnAppView: some View {
        Button("Rate on AppStore") { manager.rateApp() }
    }
}

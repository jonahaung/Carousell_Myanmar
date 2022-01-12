//
//  SettingsView.swift
//  MyBike
//
//  Created by Aung Ko Min on 12/9/21.
//

import SwiftUI

struct AppSettingsView: View {
    
    @StateObject private var manager = AppSettingsViewManager()
    @EnvironmentObject private var appUserDefault: AppUserDefault
    
    var body: some View {
        List {
            Section("Backend") {
                DisclosureGroup("Cached", isExpanded: $manager.showAll) {
                    DisclosureGroup("Fetch Limit") {
                        Stepper("\(appUserDefault.maxQueryLimit)", value: $appUserDefault.maxQueryLimit, in: 5...50)
                    }
                    Toggle("Datasource (\(AppBackendManager.shared.datasourceCount))", isOn: $appUserDefault.isCachedForLocalData)
                    Toggle("Items (\(manager.storeSize))", isOn: $appUserDefault.isCachedForRemoteData)
                    Toggle("Firestore", isOn: $appUserDefault.isCachedForeFirestoreData)
                    
                }
            }
            
            Section("Theme") {
                DisclosureGroup("Tint Color") {
                    ForEach(AppUserDefault.AppTintColor.allCases, id: \.self) { color in
                        Button {
                            withAnimation {
                                appUserDefault.tintColor = color
                            }
                        } label: {
                            HStack {
                                Image(systemName: appUserDefault.tintColor == color ? "checkmark.circle.fill" : "circlebadge.fill")
                                    .foregroundColor(color.color)
                                Text(color.rawValue)
                                Spacer()
                                
                            }
                        }.buttonStyle(.borderless)
                    }
                }
            }
            Section("Device") {
                openDeveiceSettingsRow
                shareAppRow
                privacyPolicyRow
                rateOnAppView
            }
        }
        .embeddedInNavigationView("Settings")
        .task {
            manager.getStoreSize()
        }
    }
}


extension AppSettingsView {
    
    private var privacyPolicyRow: some View {
        Button("Privacy Policy Website") { manager.gotoPrivacyPolicy() }
    }
    
    private var openDeveiceSettingsRow: some View {
        Button("Open Device Settings") { manager.gotoDeviceSettings() }
    }
    
    private var shareAppRow: some View {
        let url = URL(string: "https://apps.apple.com/us/app/bmcamera/id1560405807")!
        return Text("Share")
            .tapToPresent(ActivityView(activityItems: [url]), false)
    }
    private var rateOnAppView: some View {
        Button("Rate on AppStore") { manager.rateApp() }
    }
}

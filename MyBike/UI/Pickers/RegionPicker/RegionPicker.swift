//
//  TownshipPicker.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct RegionPicker: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var currentRegion: MyanmarState.Township?
    
    @StateObject var locationManager = LocationManager()
    
    var address: Item.Address
    var onPick: ((Item.Address) -> Void)
    
    @State private var searchText = ""
    @State private var showLoading = false
    
    @State private var myanmarStates = MyanmarState.states
    
    private var results: [MyanmarState] {
        return searchText.isEmpty ? myanmarStates : myanmarStates.map({ state in
            let townships = state.townships.filter{ $0.township.starts(with: searchText) }.sorted { $0.township > $1.township }
            return MyanmarState(name: state.name, townships: townships)
        }) + myanmarStates.filter{ $0.name.starts(with: searchText) }
    }
    
    var body: some View {
        List {
            if let address = locationManager.address {
                let myanmarState = MyanmarState(name: address.state, townships: [.init(township: address.township, township_mm: address.township)])
                stateSection(for: myanmarState)
            }
            
            ForEach(results) {
                stateSection(for: $0)
            }
        }
        .navigationBarTitle("Townships")
        .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search Townships")
        .task {
            locationManager.requestLocation()
        }
    }
    
    private func stateSection(for state: MyanmarState) -> some View {
        Group {
            if !state.townships.isEmpty {
                Section(state.name) {
                    ForEach(state.townships) { township in
                        Button {
                            onPick(Item.Address.init(state: state.name, township: township.township))
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack {
                                Text(township.township)
                                    .foregroundColor(.primary)
                                Spacer()
                                if township.township == self.address.township {
                                    Image(systemName: "checkmark.circle.fill")
                                }
                                Text(township.township_mm)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .id(township.township)
                    }
                }
                .id(state.name)
            }
        }
    }

    
    private var loadingItem: some View {
        Group{
            if showLoading {
                ProgressView()
            }else {
                Button("Current") {
                    
                }
            }
        }
    }
}

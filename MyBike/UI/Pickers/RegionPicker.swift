//
//  TownshipPicker.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct RegionPicker: View {
    
    @State private var currentRegion: MyanmarState.Township?
    
    @Environment(\.presentationMode) private var presentationMode
    private let getLocation = GetLocation()
    @Binding var address: Item.Address
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
            ForEach(results) {
                stateSection(for: $0)
            }
        }
        .navigationBarTitle("Townships")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Townships")
        .onAppear {
            getCurrentAddress()
        }
    }
    private func stateSection(for state: MyanmarState) -> some View {
        Group {
            if !state.townships.isEmpty {
                Section(state.name) {
                    ForEach(state.townships) { township in
                        Button {
                            let selected = Item.Address.init(state: state.name, township: township.township)
                            self.address = selected
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
    
    
    private func getCurrentAddress() {
        guard !showLoading else { return }
        showLoading = true
        getLocation.run { location in
            if let location = location {
                GeoCoder.getAddress(from: location) { address, error in
                    if let address = address {
                        let myanmarState = MyanmarState(name: address.state, townships: [.init(township: address.township, township_mm: address.township)])
                        DispatchQueue.main.async {
                            self.showLoading = false
                            if !self.myanmarStates.contains(myanmarState) {
                                if self.address.isEmpty {
                                    self.address = address
                                }
                                self.myanmarStates.insert(myanmarState, at: 0)
                            }
                        }
                    }
                }
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

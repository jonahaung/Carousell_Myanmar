//
//  HomeSearchView.swift
//  MyBike
//
//  Created by Aung Ko Min on 24/11/21.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject private var searchManager: SearchViewManager
    @EnvironmentObject private var authenticationService: AuthenticationService
    @Environment(\.isSearching) private var isSearching: Bool
    
    var body: some View {
        Group {
            if isSearching {
                List {
                    Search_Section_Completions()
                    
                    Search_Section_Categories()
                    
                    Search_Section_Suggesstions()
                        
                    Search_Section_FinalResults()
                }
            }
        }
        .onChange(of: isSearching) { newValue in
            AppAlertManager.shared.isSearching = newValue
            
        }
    }
    
    private var progressView: some View {
        ProgressView().opacity(searchManager.isSearching ? 1 : 0)
    }
    
    
}

//
//  Search_Section_FinalResults.swift
//  MyBike
//
//  Created by Aung Ko Min on 1/1/22.
//

import SwiftUI

struct Search_Section_FinalResults: View {
    
    @EnvironmentObject private var searchManager: SearchViewManager
    
    var body: some View {
        Section {
            ForEach(searchManager.finalResults) {
                SearchResultCell()
                    .environmentObject($0)
            }
        }
    }
}

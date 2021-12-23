//
//  PagnitionProgressView.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/11/21.
//

import SwiftUI

struct PagnitionProgressView: View {
    
    @Binding var hasMoreData: Bool
    @Binding var isLoading: Bool
    
    var loadMoreIfNeeded: () -> Void
    var refresh: () -> Void
    
    var body: some View {
        VStack {
            if hasMoreData {
                if isLoading {
                    ProgressView()
                }else {
                    Text("..").task {
                        loadMoreIfNeeded()
                    }
                }
            }else {
                Text("No more data")
                    .onTapGesture {
                        refresh()
                    }
            }
            Divider().padding()
        }
        .frame(height: 100)
    }
}

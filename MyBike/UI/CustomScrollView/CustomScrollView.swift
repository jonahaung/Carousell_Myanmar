//
//  ScrollViewOffset.swift
//  MyBike
//
//  Created by Aung Ko Min on 23/12/21.
//

import SwiftUI

private struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}


struct CustomScrollView<Content: View>: View {
    
    private let content: () -> Content
    
    @Environment(\.refresh) var refreshAction: RefreshAction?
    @StateObject private var manager = CustomScrollViewManager()
    @State private var isRefreshing = false
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: true) {
                VStack {
                    refresher()
                    content()
                }
                .padding(.bottom, 50)
                .background(Color.groupedTableViewBackground.frame(height: 99999999))
                .anchorPreference(key: OffsetPreferenceKey.self, value: .top) {
                    geometry[$0].y
                }
            }
            .onPreferenceChange(OffsetPreferenceKey.self) {
                if refreshAction != nil, !isRefreshing, manager.canRefresh(for: $0) {
                    Task {
                        isRefreshing = true
                        await refreshAction?()
                        manager.isStarting = false
                        isRefreshing = false
                    }
                }
            }
        }
    }
    
    private func refresher() -> some View {
        Group {
            if manager.isStarting {
                if isRefreshing {
                    ProgressView()
                        .padding(.top)
                }else {
                    Image(systemName: "circlebadge.fill")
                        .padding(.top)
                        .foregroundColor(.secondary)
                    
                }
                
            }
        }
    }
}

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
private struct BottomOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

struct ScrollViewOffset<Content: View>: View {
    
    let content: () -> Content
    let onScrolledTop: (CGFloat) -> Void
    
    @State private var progress = CGFloat.zero
    @State private var scrollDirection = ScrollDirection.stop
    
    init(@ViewBuilder content: @escaping () -> Content, onScrolledTop: @escaping (CGFloat) -> Void) {
        self.content = content
        self.onScrolledTop = onScrolledTop
    }
    
    var body: some View {
        ScrollView(showsIndicators: true) {
            topOffsetReader
            content()
        }
        .coordinateSpace(name: "frameLayer")
        .onPreferenceChange(OffsetPreferenceKey.self, perform: topPreferenceChanged)
    }

    enum ScrollDirection {
        case top, bottom, stop
    }
    
    private func topPreferenceChanged(_ value: CGFloat) {
        let oldProgress = self.progress
        self.progress = value.rounded()
        
        let difference = progress - oldProgress
        
        let oldScrollDirection = self.scrollDirection
        self.scrollDirection = difference == 0 ? ScrollDirection.stop : progress > oldProgress ? .top : .bottom
        guard oldScrollDirection != self.scrollDirection else { return }
        
        if min(130, max(0, oldProgress)) == 130 {
            onScrolledTop(value)
        }
    }

    var topOffsetReader: some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .named("frameLayer"))
            ProgressView.init(value: CGFloat(truncating: min(130, max(0, progress)) as NSNumber), total: 130)
                .padding(.horizontal)
            .preference(
              key: OffsetPreferenceKey.self,
              value: frame.minY
            )
        }
    }
    
    
}

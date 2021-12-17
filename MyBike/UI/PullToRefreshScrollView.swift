//
//  PullToRefreshScrollView.swift
//  MyBike
//
//  Created by Aung Ko Min on 10/12/21.
//



import SwiftUI

// There are two type of positioning views - one that scrolls with the content,
// and one that stays fixed
private enum PositionType {
    case fixed, moving
}

// This struct is the currency of the Preferences, and has a type
// (fixed or moving) and the actual Y-axis value.
// It's Equatable because Swift requires it to be.
private struct Position: Equatable {
    let type: PositionType
    let y: CGFloat
}

// This might seem weird, but it's necessary due to the funny nature of
// how Preferences work. We can't just store the last position and merge
// it with the next one - instead we have a queue of all the latest positions.
private struct PositionPreferenceKey: PreferenceKey {
    typealias Value = [Position]
    
    static var defaultValue = [Position]()
    
    static func reduce(value: inout [Position], nextValue: () -> [Position]) {
        value.append(contentsOf: nextValue())
    }
}

private struct PositionIndicator: View {
    let type: PositionType
    
    var body: some View {
        GeometryReader { proxy in
            // the View itself is an invisible Shape that fills as much as possible
            Color.clear
            // Compute the top Y position and emit it to the Preferences queue
                .preference(key: PositionPreferenceKey.self, value: [Position(type: type, y: proxy.frame(in: .global).minY)])
        }
    }
}

// Callback that'll trigger once refreshing is done
public typealias RefreshComplete = () -> Void
// The actual refresh action that's called once refreshing starts. It has the
// RefreshComplete callback to let the refresh action let the View know
// once it's done refreshing.
public typealias OnRefresh = (@escaping RefreshComplete) -> Void

// The offset threshold. 68 is a good number, but you can play
// with it to your liking.
private let THRESHOLD: CGFloat = 120

// Tracks the state of the RefreshableScrollView - it's either:
// 1. waiting for a scroll to happen
// 2. has been primed by pulling down beyond THRESHOLD
// 3. is doing the refreshing.
public enum RefreshState {
    case waiting, primed, loading
}

// ViewBuilder for the custom progress View, that may render itself
// based on the current RefreshState.
public typealias RefreshProgressBuilder<Progress: View> = (RefreshState) -> Progress

public struct RefreshableScrollView<Progress, Content>: View where Progress: View, Content: View {
    let showsIndicators: Bool // if the ScrollView should show indicators
    let onRefresh: OnRefresh // the refreshing action
    let progress: RefreshProgressBuilder<Progress> // custom progress view
    let content: () -> Content // the ScrollView content
    @State private var state = RefreshState.waiting // the current state
    
    let feedbackGenerator = UINotificationFeedbackGenerator() // haptic feedback
    // We use a custom constructor to allow for usage of a @ViewBuilder for the content
    public init(showsIndicators: Bool = true,
                onRefresh: @escaping OnRefresh,
                @ViewBuilder progress: @escaping RefreshProgressBuilder<Progress>,
                @ViewBuilder content: @escaping () -> Content) {
        self.showsIndicators = showsIndicators
        self.onRefresh = onRefresh
        self.progress = progress
        self.content = content
    }
    
    public var body: some View {
        // The root view is a regular ScrollView
        ScrollView(showsIndicators: showsIndicators) {
            // The ZStack allows us to position the PositionIndicator,
            // the content and the loading view, all on top of each other.
            ZStack(alignment: .top) {
                PositionIndicator(type: .moving)
                    .frame(height: 0)
                content()
                    .alignmentGuide(.top, computeValue: { _ in
                        (state == .loading) ? -THRESHOLD : 0
                    })
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: THRESHOLD)
                    progress(state)
                }.offset(y: (state == .loading) ? 0 : -THRESHOLD)
            }
        }
        // Put a fixed PositionIndicator in the background so that we have
        // a reference point to compute the scroll offset.
        .background(PositionIndicator(type: .fixed).background(Color.tertiarySystemGroupedBackground))
        // Once the scrolling offset changes, we want to see if there should
        // be a state change.
        .onPreferenceChange(PositionPreferenceKey.self) { values in
            if state != .loading { // If we're already loading, ignore everything
                DispatchQueue.main.async {
                    let movingY = values.first { $0.type == .moving }?.y ?? 0
                    let fixedY = values.first { $0.type == .fixed }?.y ?? 0
                    let offset = movingY - fixedY
                    
                    // If the user pulled down below the threshold, prime the view
                    if offset > THRESHOLD && state == .waiting {
                        state = .primed
                        self.feedbackGenerator.notificationOccurred(.success)
                    } else if offset < THRESHOLD && state == .primed {
                        withAnimation {
                            state = .loading
                        }
                        onRefresh {
                            withAnimation {
                                self.state = .waiting
                            }
                        }
                    }
                }
            }
        }
    }
}

// Extension that uses default RefreshActivityIndicator so that you don't have to
// specify it every time.
extension RefreshableScrollView where Progress == RefreshActivityIndicator {
    init(showsIndicators: Bool = true,
         onRefresh: @escaping OnRefresh,
         @ViewBuilder content: @escaping () -> Content) {
        self.init(showsIndicators: showsIndicators,
                  onRefresh: onRefresh,
                  progress: { state in
            RefreshActivityIndicator(isAnimating: state == .loading)
        },
                  content: content)
    }
}

// Wraps a UIActivityIndicatorView as a loading spinner that works on all SwiftUI versions.

struct RefreshActivityIndicator: View {
    @State var isAnimating = false
    var body: some View {
        ProgressView().opacity(isAnimating ? 1 : 0)
    }
}

#if compiler(>=5.5)
// Allows using RefreshableScrollView with an async block.
@available(iOS 15.0, *)
public extension RefreshableScrollView {
    init(showsIndicators: Bool = true,
         action: @escaping @Sendable () async -> Void,
         @ViewBuilder progress: @escaping RefreshProgressBuilder<Progress>,
         @ViewBuilder content: @escaping () -> Content) {
        self.init(showsIndicators: showsIndicators,
                  onRefresh: { refreshComplete in
            Task {
                await action()
                refreshComplete()
            }
        },
                  progress: progress,
                  content: content)
    }
}
#endif

public struct RefreshableCompat<Progress>: ViewModifier where Progress: View {
    private let showsIndicators: Bool
    private let onRefresh: OnRefresh
    private let progress: RefreshProgressBuilder<Progress>
    
    public init(showsIndicators: Bool = true,
                onRefresh: @escaping OnRefresh,
                @ViewBuilder progress: @escaping RefreshProgressBuilder<Progress>) {
        self.showsIndicators = showsIndicators
        self.onRefresh = onRefresh
        self.progress = progress
    }
    
    public func body(content: Content) -> some View {
        RefreshableScrollView(showsIndicators: showsIndicators,
                              onRefresh: onRefresh,
                              progress: progress) {
            content
        }
    }
}

#if compiler(>=5.5)
@available(iOS 15.0, *)
public extension List {
    @ViewBuilder func refreshableCompat<Progress: View>(showsIndicators: Bool = true,
                                                        onRefresh: @escaping OnRefresh,
                                                        @ViewBuilder progress: @escaping RefreshProgressBuilder<Progress>) -> some View {
        self.refreshable {
            await withCheckedContinuation { cont in
                onRefresh {
                    cont.resume()
                }
            }
        }
    }
}
#endif

public extension View {
    @ViewBuilder func refreshableCompat<Progress: View>(showsIndicators: Bool = true,
                                                        onRefresh: @escaping OnRefresh,
                                                        @ViewBuilder progress: @escaping RefreshProgressBuilder<Progress>) -> some View {
        self.modifier(RefreshableCompat(showsIndicators: showsIndicators, onRefresh: onRefresh, progress: progress))
    }
}

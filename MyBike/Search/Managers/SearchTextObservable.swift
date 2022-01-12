//
//  SearchTextObservable.swift
//  MyBike
//
//  Created by Aung Ko Min on 28/11/21.
//

import SwiftUI
import Combine

open class SearchTextObservable: ObservableObject {
    
    
    
    @Published public var searchText = "" {
        willSet {
            DispatchQueue.main.async {
                self.searchSubject.send(newValue)
            }
        }
        didSet {
            Task {
                await self.onUpdateText(text: self.searchText)
            }
        }
    }
        
    public let searchSubject = PassthroughSubject<String, Never>()
    
    private var searchCancellable: Cancellable? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    deinit {
        searchCancellable?.cancel()
    }
    
    public init() {
        searchCancellable = searchSubject.eraseToAnyPublisher()
            .map {
                $0
        }
        .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
        .removeDuplicates()
        .filter { !$0.isEmpty }
        .sink(receiveValue: { (searchText) in
            Task {
                await self.onUpdateTextDebounced(text: searchText)
            }
        })
    }
    @MainActor
    open func onUpdateText(text: String) async {
        /// Overwrite by your subclass to get instant text update.
    }
    
    @MainActor
    open func onUpdateTextDebounced(text: String) async {
        /// Overwrite by your subclass to get debounced text update.
    }
}

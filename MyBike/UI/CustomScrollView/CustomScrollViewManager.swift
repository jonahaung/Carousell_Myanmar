//
//  CustomScrollViewManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 11/1/22.
//

import SwiftUI

class CustomScrollViewManager: ObservableObject {
    
    enum Direction {
        case top, bottom, stop
    }

    private let threshold: CGFloat = 150
    private let limit = 30
    private var counter = 0

    private var scrollDirection = Direction.stop
    private var progress = CGFloat.zero
    
    var isStarting = false  {
        willSet {
            guard newValue != isStarting else { return }
            withAnimation(.interactiveSpring()) {
                objectWillChange.send()
            }
        }
    }

    
    func canRefresh(for value: CGFloat) -> Bool {
    
        let newProgress = value.rounded()
        
        if isStarting {
            if newProgress < 2 {
                return true
            }
            return false
        }else if newProgress > threshold {
            isStarting = true
            Vibration.medium.vibrate()
        }else {
            isStarting = false
            progress = newProgress
        }
        return false
    }
    
    func changedDirection(for value: CGFloat) -> Direction? {
        let oldProgress = self.progress
        let newProgress = value.rounded()
        
        let difference = abs(abs(newProgress) - abs(oldProgress))
        let newDirection = difference < 3 ? CustomScrollViewManager.Direction.stop : (newProgress > oldProgress ? CustomScrollViewManager.Direction.top : .bottom)
        
        if isStableDirection(newDirection: newDirection) {
            return newDirection
        }
        scrollDirection = newDirection
        return nil
    }
    
    private func isStableDirection(newDirection: Direction) -> Bool {
        if scrollDirection == newDirection {
            counter += 1
        } else {
            counter = 0
        }
        
        return counter == limit
    }
}

//
//  ActionSheet.swift
//  MyBike
//
//  Created by Aung Ko Min on 2/1/22.
//

import Foundation
import SwiftUI

extension ActionSheet {
    
    static func sortActionSheet(_ onAction: ((ItemSort) -> Void)? = nil) -> ActionSheet {
        
        let byDate: Alert.Button = .default(Text("Sort by added date")) {
            onAction?(.byAddedDate)
        }
        let byLikes: Alert.Button = .default(Text("Sort by likes")) {
            onAction?(.byPopularity)
        }
        let byViews: Alert.Button = .default(Text("Sort by views")) {
            onAction?(.byViews)
        }
        
        let sheet = ActionSheet(title: Text("Sort movies by"), message: nil, buttons: [byDate, byLikes, byViews, .cancel()])
        return sheet
    }
    
    static func itemDetailOwnerMenuActionSheet(_ viewModel: ItemViewModel, _ onAction: ((ItemViewModel.Action.OwnerAction) -> Void)? = nil) -> ActionSheet {
        var allProgress = Item.Status.allCases
        if let index = allProgress.firstIndex(of: viewModel.item.status) {
            allProgress.remove(at: index)
        }
        var buttons = [Alert.Button]()
        allProgress.forEach { progress in
            let button: Alert.Button = .default(Text("Make \(progress.rawValue)")) {
                onAction?(.updateStatus(progress))
            }
            buttons.append(button)
        }
        buttons.append(
            .destructive(Text("Delete"), action: {
                onAction?(.delete)
            })
        )
        buttons.append(
            .default(Text("Edit"), action: {
                onAction?(.edit)
            })
        )
        buttons.append(.cancel())
        
        let sheet = ActionSheet(title: Text("Sort movies by"), message: nil, buttons: buttons)
        return sheet
    }
}

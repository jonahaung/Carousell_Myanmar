//
//  Item.Actions.swift
//  MyBike
//
//  Created by Aung Ko Min on 26/12/21.
//

import Foundation
import Firebase

extension ItemViewModel {
    
    enum Action {
        case toggleFavourites(CurrentUserViewModel)
        case setHasViewed(CurrentUserViewModel)
        case addComment(comment: Item.Comment, _ done: ()->Void)
        case updateCurrentUser(CurrentUserViewModel)
        case ownerAction(OwnerAction)
        case exchangeType(Item.ExchangeType)
        enum OwnerAction {
            case delete
            case updateStatus(Item.Status)
            case edit
        }
    }
    
    func setAction(_ action: Action) {
        switch action {
        case .toggleFavourites(let x):
            toggleFavourite(x)
            Vibration.light.vibrate()
        case .setHasViewed(let x):
            updateViewCount(x)
        case .addComment(let c, let d):
            addComments(comment: c, d)
            Vibration.light.vibrate()
        case .updateCurrentUser(let x):
            updateCurrentUser(x)
        case .ownerAction(let x):
            switch x {
            case .delete:
                delete()
            case .updateStatus(let x):
                updateProgress(x)
            case .edit:
                break
            }
        case .exchangeType(let x):
            setExchangeType(x)
        }
    }
}

extension ItemViewModel {
    
    private func setExchangeType(_ exchangeType: Item.ExchangeType) {
        var newItem = self.item
        newItem.exchangeType = exchangeType
        update(newItem)
    }
    private func updateProgress( _ status: Item.Status) {
        var newItem = self.item
        newItem.status = status
        update(newItem)
    }
    private func updateCurrentUser(_ currentUserViewModel: CurrentUserViewModel) {
        currentUserViewModel.setAction(.updateHistory(.category(item.category), .Add))
    }
    
    private func toggleFavourite(_ currentUserViewModel: CurrentUserViewModel) {
        guard let uid = currentUserViewModel.person.id else { return }
        var newItem = self.item
        var uids = newItem.favourites.uids
        
        if newItem.favourites.isFavourite {
            if let index = uids.firstIndex(of: uid) {
                uids.remove(at: index)
            }
        } else {
            uids.append(uid)
        }
        newItem.favourites = Item.Favourites(count: uids.count, uids: uids)
        update(newItem) {
            let text = newItem.favourites.isFavourite ? "You have added this item to your favourites list" : "You have removed it from your saved list"
            let priority = newItem.favourites.isFavourite ? NotificationBadge.Notification.Priority.Success : .Error
            
            AppAlertManager.shared.notification = .init(text, priority)
        }
    }
    
    
    private func updateViewCount(_ currentUserViewModel: CurrentUserViewModel) {
        var newItem = item
        let count = newItem.views.count
        var uids = item.views.uids
        if !newItem.views.hasViewed, let uid = currentUserViewModel.person.id {
            uids.append(uid)
        }
        newItem.views = Item.Views(count: count + 1, uids: uids)
        update(newItem)
    }
    
    private func addComments(comment: Item.Comment, _ done: @escaping SomeAction) {
        var newItem = item
        let comments = newItem.comments
        newItem.comments = comments + [comment]
        update(newItem, done)
    }
    
    func delete() {
        AppAlertManager.shared.onComfirm(buttonText: "Confirm Delete") {
            ItemRepository.shared.remove(self.item) {
                AppAlertManager.shared.notification.text = "Item Deleted"
            }
        }
    }
    
    private func update(_ newItem: Item, _ done: @escaping SomeAction = {}) {
        
        ItemRepository.shared.update(newItem) {
            self.handleError($0)
            self.item = newItem
            done()
        }
    }
    
    private func handleError(_ error: Error?) {
        guard let error = error else { return }
        AppAlertManager.shared.notification.text = error.localizedDescription
    }
}

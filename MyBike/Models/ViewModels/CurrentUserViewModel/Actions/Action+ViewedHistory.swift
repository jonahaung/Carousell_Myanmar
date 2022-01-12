//
//  Action+ViewedHistory.swift
//  MyBike
//
//  Created by Aung Ko Min on 10/1/22.
//

import Foundation

extension CurrentUserViewModel {
    
    func updateHistor(historyType: Person.ViewedHistory.ViewedHistoryType, actionType: ActionType) {
        switch actionType {
        case .RemoveAll:
            let alertObject = AlertObject("Are you sure to clear the history", buttonText: "Yes, Clear All Histories", role: .destructive) {
                var newPerson = self.person
                newPerson.viewedHistory.categories = []
                newPerson.viewedHistory.searchedWords = []
                self.personRepo.update(newPerson) { error in
                    self.person = newPerson
                }
            } cancelAction: {
                print("Cancel")
            }
            AppAlertManager.shared.alert = alertObject
        default:
            switch historyType {
            case .category(let category):
                self.updateCategories(category, actionType)
            case .searchWords(let word):
                self.updateSearchTexts(word, actionType)
            }
        }
    }
    
    private func updateSearchTexts(_ text: String, _ actionType: ActionType) {
        let text = text.lowercased()
        var history = person.viewedHistory
        var searchWords = history.searchedWords
        if actionType == .Delete {
            if let index = searchWords.firstIndex(of: text) {
                searchWords.remove(at: index)
            }
        } else {
            if !searchWords.contains(text) {
                searchWords.insert(text, at: 0)
            }
        }
        history.searchedWords = searchWords
        var newPerson = person
        newPerson.viewedHistory = history
        personRepo.update(newPerson) { error in
            self.person = newPerson
        }
    }
    
    private func updateCategories(_ category: Category, _ actionType: ActionType) {
        var history = person.viewedHistory
        var categories = history.categories
        
        if actionType == .Delete {
            if let index = categories.firstIndex(of: category) {
                categories.remove(at: index)
            }
        }else {
            if !categories.contains(category) {
                categories.insert(category, at: 0)
            }
        }
        
        history.categories = categories.unique
        
        var newPerson = person
        newPerson.viewedHistory = history
        personRepo.update(newPerson) { error in
            self.person = newPerson
        }
        
    }
}

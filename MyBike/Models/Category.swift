//
//  Category.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/11/21.
//

import Foundation

struct Category: Codable, Identifiable, Hashable {
    
    static let rootNode: Category = {
        var root = Category(title: "root")
        if let url = Bundle.main.url(forResource: "Categories", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                root = try JSONDecoder().decode(Category.self, from: data)
            }catch {
                print(error)
            }
        }
        return root
    }()
    static var categories: [Category] { return rootNode.children ?? [] }
    static let allValues: [Category] = {
        var results = [Category]()
        Category.categories.forEach {
            if let children = $0.children {
                results += children
            }
        }
        return results
    }()
    
    
    var id: String { return title }
    let title: String
    var children: [Category]?
    
    init(title: String) {
        self.title = title
    }
    
    var hasChildren: Bool { children?.count ?? 0 > 0 }
    var isTopItem: Bool { parentNode == Category.rootNode }
}

extension Category {
    
    static let none = Category(title: "none")
    var isSelected: Bool { return title != "none" }
    
    var isEmpty: Bool { !isSelected }
    
    var parentNode: Category? {
        return Category.rootNode.findParent(title, parentNode: nil)
    }
    
    func findParent(_ title: String, parentNode: Category?) -> Category? {
        if title == self.title {
            return parentNode
        }
        for child in children ?? [] {
            if let found = child.findParent(title, parentNode: self) {
                return found
            }
        }
        return nil
    }
}

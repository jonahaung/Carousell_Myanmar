//
//  Category.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/11/21.
//

import Foundation

struct Category: Identifiable, Codable {
    
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
    
    var id: String { return title }
    let title: String
    var children: [Category]?
    
    init(title: String) {
        self.title = title
    }
    
}

extension Category {
    
    static let none = Category(title: "Select Category")
    var isSelected: Bool { return title != "Select Category" }
    
    var count: Int {
        guard let children = children else { return 1 }
        return 1 + children.reduce(0) { $0 + $1.count }
    }
    
    func find(_ title: String) -> Category? {
        if self.title == title {
            return self
        }
        guard let children = children else {
            return nil
        }
        
        for child in children {
            if let match = child.find(title) {
                return match
            }
        }
        return nil
    }
    
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

extension Category: Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.title == rhs.title && lhs.children == rhs.children
    }
}
extension Category: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(children)
    }
}

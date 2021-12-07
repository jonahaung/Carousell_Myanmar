//
//  MyanmarState.swift
//  MyBike
//
//  Created by Aung Ko Min on 6/12/21.
//

import Foundation

struct MyanmarState: Codable, Identifiable, Comparable {
    
    static func < (lhs: MyanmarState, rhs: MyanmarState) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: MyanmarState, rhs: MyanmarState) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    var id: String { name + townships.count.description }
    
    let name: String
    let townships: [Township]
    
    struct Township: Codable, Identifiable {
        var id: String { township }
        let township: String
        let township_mm: String
    }
    
    static let states: [MyanmarState] = {
        var results = [MyanmarState]()
        if let url = Bundle.main.url(forResource: "myanmarstates", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                results = try JSONDecoder().decode([MyanmarState].self, from: data)
            } catch {
                print(error)
            }
        }
        return results
    }()
}

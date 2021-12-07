//
//  PeopleViewModel.swift
//  MyBike
//
//  Created by Aung Ko Min on 11/11/21.
//

import Combine
import Firebase

class PersonViewModel: ObservableObject, Identifiable {
    
    var id = ""
    
    @Published var person: Person
    
    private var cancellables: Set<AnyCancellable> = []
    private let personRepo = PersonRepository()
    
    init(person: Person) {
        self.person = person
        $person
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
}

//
//  Task.swift
//  Task
//
//  Created by lijia xu on 7/21/21.
//

import Foundation

class Task: Codable {
    

    var name: String
    var notes: String?
    var dueDate: Date?
    var isComplete: Bool
    
    internal init(name: String, notes: String? = nil, dueDate: Date? = nil, isComplete: Bool = false) {
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
    
}

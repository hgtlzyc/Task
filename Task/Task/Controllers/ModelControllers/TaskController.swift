//
//  TaskController.swift
//  Task
//
//  Created by lijia xu on 7/21/21.
//

import Foundation

class TaskController {
    
    static let shared = TaskController()
    
    var tasks: [Task] = []
    
    
    // MARK: - CRUD Functions
    func createTaskWith(name: String, notes: String?, dueDate: Date?){
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        saveToPersistanceStore()
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?){
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        
        saveToPersistanceStore()
    }
    
    func toggleIsComplete(task: Task){
        task.isComplete.toggle()
        saveToPersistanceStore()
    }
    
    func delete(task: Task){
        //it is holding class instance, can use === check for identity
        let indexToDelete = tasks.firstIndex{ $0 === task }
        guard let index = indexToDelete else { return }
        tasks.remove(at: index)
        saveToPersistanceStore()
    }

    // MARK: - Data Store
    private func getPersistenceURL() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Tasks.json")
        return fileURL
    }
    
    func saveToPersistanceStore() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: getPersistenceURL())
        } catch let e {
            print(e)
        }
    }
    
    func loadFromPeristenceStore() {
        do {
            let data = try Data(contentsOf: getPersistenceURL())
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch let e {
            print(e)
        }
    }
    
    
    // MARK: - Make init private
    private init() {}
    
}

//
//  TaskDetailViewController.swift
//  Task
//
//  Created by lijia xu on 7/21/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    var task: Task?
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskNameTextField.delegate = self
        taskNotesTextView.delegate = self
        updateViews()
    }
    
    func updateViews() {
        if let task = task {
            date = task.dueDate
            taskDueDatePicker.date = task.dueDate ?? Date()
            taskNameTextField.text = task.name
            taskNotesTextView.text = task.notes ?? ""
        } else {
            date = taskDueDatePicker.date
        }
        
    }
    
    // MARK: - IB Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        defer {
            navigationController?.popViewController(animated: true)
        }
        guard let taskName = taskNameTextField.text,
              let taskNotes = taskNotesTextView.text,
              !taskName.isEmpty,
              !taskNotes.isEmpty else { return }
        
        if let task = task {
            TaskController.shared.update(task: task, name: taskName, notes: taskNotes, dueDate: date)
            
        } else {
            TaskController.shared.createTaskWith(name: taskName, notes: taskNotes, dueDate: date)
        }
        
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        guard let datePicker = sender as? UIDatePicker else { return }
        date = datePicker.date
    }
} //End Of VC

extension TaskDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskNameTextField.resignFirstResponder()
        return true
    }
}

extension TaskDetailViewController: UITextViewDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        taskNotesTextView.resignFirstResponder()
        return true
    }
}

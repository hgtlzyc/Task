//
//  TaskListTableViewController.swift
//  Task
//
//  Created by lijia xu on 7/21/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        TaskController.shared.loadFromPeristenceStore()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell()}
        
        cell.task = TaskController.shared.tasks[indexPath.row]
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.delete(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetailVC" {
            guard let indexPathSelected = tableView.indexPathForSelectedRow,
                  let targetVC = segue.destination as? TaskDetailViewController else { return }
            targetVC.task = TaskController.shared.tasks[indexPathSelected.row]
            
        }
        
    }
    
}//End Of VC


extension TaskListTableViewController: TaskCompletionDelegate {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        sender.task?.isComplete.toggle()
        sender.updateViews()
        TaskController.shared.saveToPersistanceStore()
    }

}

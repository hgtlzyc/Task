//
//  TaskTableViewCell.swift
//  Task
//
//  Created by lijia xu on 7/21/21.
//

import UIKit

protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}


class TaskTableViewCell: UITableViewCell {
    

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    weak var delegate: TaskCompletionDelegate?
    
    var task: Task? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        guard let task = task else { return }
        taskNameLabel.text = task.name
        let buttonImage = task.isComplete ? UIImage(named: "complete") : UIImage(named: "incomplete")
        completionButton.setBackgroundImage(buttonImage, for: .normal)
    }
    
    @IBAction func completionButtonTapped(_ sender: UIButton) {
        delegate?.taskCellButtonTapped(self)
        
    }
    
}

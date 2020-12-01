//
//  ToDoTableCell.swift
//  ToDoList
//
//  Created by stone on 2018/01/27.
//  Copyright © 2018年 stone. All rights reserved.
//

import UIKit

class ToDoTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var registrationDateLabel: UILabel!
    @IBOutlet weak var limitDateLabel: UILabel!
    @IBOutlet var priorityStars: [UIImageView]!
    
    func setItem(_ item: ToDo) {
        self.titleLabel.text = item.title
        self.limitDateLabel.text = item.limitDate.toStrByAppDefStyle()
        self.registrationDateLabel.text = item.registrationDate.toStrByAppDefStyle()
        self.dispPriorityStars(priority: item.priority)
        self.updateLimitLabel(item)
    }
    
    private func dispPriorityStars(priority: Int) {
        priorityStars.forEach { $0.isHidden = ($0.tag > priority) }
    }
    
    private func updateLimitLabel(_ toDo: ToDo) {
        if(toDo.isLimited) {
            if (toDo.limitDate < Date()) {
                self.limitDateLabel.textColor = UIColor.red
            } else {
                self.limitDateLabel.textColor = UIColor.black
            }
        } else {
            self.limitDateLabel.textColor = UIColor.gray
        }
    }
    
}

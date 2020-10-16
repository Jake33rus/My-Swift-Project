//
//  TaskCell.swift
//  ToDoApp(UnitTests)
//
//  Created by Евгений Уланов on 13.10.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var dateFormatter: DateFormatter{
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    func configure(withTask task: Task, done: Bool = false){
        if done{
            let attributedString = NSAttributedString(string: task.title, attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
            titleLabel.attributedText = attributedString
            dateLabel.text = ""
            locationLabel.text = ""
        }
        else{
            let dateString = dateFormatter.string(from: task.date)
            dateLabel.text = dateString
            titleLabel.attributedText = NSAttributedString(string: task.title, attributes: [:])
            locationLabel.text = task.location?.name
        }
        
    }
    
    
}

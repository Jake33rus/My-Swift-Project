//
//  ViewController.swift
//  Checklists
//
//  Created by Евгений Уланов on 20.09.2020.
//

import UIKit

class ViewController: UITableViewController {
    
    var examples: [(String, [Checklist])] = []
    
    override func viewDidLoad() {
        let examle = Examples()
        self.examples = [examle.actuals, examle.badHabits, examle.health, examle.selfDevelopment]
        tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TVCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath as IndexPath) as! TableViewCell
        cell.exampleName.text = self.examples[indexPath.row].0
        cell.checkLists = self.examples[indexPath.row].1
        return cell
    }
}



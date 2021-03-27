//
//  OpenCheckListView.swift
//  Checker
//
//  Created by Евгений Уланов on 27.03.2021.
//

import UIKit

final class OpenCheckListView: UITableViewController {
    
    var examples: [(String, [Checklist])] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let examle = Examples()
        self.examples = [examle.actuals, examle.badHabits, examle.health, examle.selfDevelopment]
        tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TVCell")
    }

    // MARK: - Table view data source

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

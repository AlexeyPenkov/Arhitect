//
//  ResultTableViewController.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 09.08.2021.
//

import UIKit

class ResultTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "celReuse")
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Game.shared.records.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "celReuse", for: indexPath) as? RecordTableViewCell else { return UITableViewCell()}
        
            let record = Game.shared.records[indexPath.row]
        cell.configCell(text: "\(record.date.description) = \(record.score)")
        
        return cell
    }
}

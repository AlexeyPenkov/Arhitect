//
//  AddQuestonsWithTableViewController.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 12.08.2021.
//

import UIKit

class AddQuestonsWithTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
   
    var questionArray = [Question]()
    
    var numberOfRows = 1
    
    let cellIdentificator = "addQuestionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.register(UINib(nibName: "AddQuestionsTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentificator)
        
        addButton.layer.cornerRadius = 10
        addButton.layer.borderWidth = 3
        addButton.layer.borderColor = UIColor.systemPurple.cgColor
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderWidth = 3
        cancelButton.layer.borderColor = UIColor.systemPurple.cgColor
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderWidth = 3
        saveButton.layer.borderColor = UIColor.systemPurple.cgColor
    }
    

    
    @IBAction func canselButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveQuestionsButtonAction(_ sender: Any) {
        var cellArray = [AddQuestionsTableViewCell]()
        for i in 0 ..< numberOfRows {
            let indexPath = IndexPath(row: i, section: 0)
            guard let cell = tableView.cellForRow(at: indexPath) as? AddQuestionsTableViewCell else { return }
            cellArray.append(cell)
        }
        let builderQuesion = BuilderQuestionArray(arrayCell: cellArray)
        builderQuesion.saveQuestionArray()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addCellButtonAction(_ sender: Any) {
        self.numberOfRows += 1
        self.tableView.reloadData()
    }
}

extension AddQuestonsWithTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentificator) as? AddQuestionsTableViewCell else { return UITableViewCell()}
        return cell
    }
    
}

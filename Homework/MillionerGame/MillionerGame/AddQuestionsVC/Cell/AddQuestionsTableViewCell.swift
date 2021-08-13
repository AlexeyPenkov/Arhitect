//
//  AddQuestionsTableViewCell.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 12.08.2021.
//

import UIKit

class AddQuestionsTableViewCell: UITableViewCell {

    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var correctResponceTextField: UITextField!
    
    @IBOutlet weak var responceATextField: UITextField!
   
    @IBOutlet weak var responceBTextField: UITextField!
    
    @IBOutlet weak var responceCTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        clearTextFields()
    }
    
    func clearTextFields() {
        questionTextField.text = nil
        responceATextField.text = nil
        responceBTextField.text = nil
        responceBTextField.text = nil
        correctResponceTextField.text = nil
    }
    
}

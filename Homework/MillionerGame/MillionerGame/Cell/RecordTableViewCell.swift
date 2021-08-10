//
//  RecordTableViewCell.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 09.08.2021.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var recorsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recorsLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(text: String) {
        recorsLabel.text = text
    }
    
}

//
//  SettingViewController.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 11.08.2021.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var difficultySegmentControl: UISegmentedControl!
    
    @IBOutlet weak var backButton: UIButton!
    
    private var selectedDifficulty: Difficulty {
        switch difficultySegmentControl.selectedSegmentIndex {
        case 0:
            return .easy
        case 1:
            return .hard
        default:
            return .easy
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.layer.cornerRadius = 10
        backButton.layer.borderWidth = 3
        backButton.layer.borderColor = UIColor.systemPurple.cgColor
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonAction(_ sender: Any) {
        Game.shared.currentDifficuly = self.selectedDifficulty
        dismiss(animated: true, completion: nil)
    }
    
}

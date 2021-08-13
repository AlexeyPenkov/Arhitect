//
//  ViewController.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 06.08.2021.
//

import UIKit

class StartVC: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var scoreButton: UIButton!
    
    @IBOutlet weak var statisticLabel: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    
    @IBOutlet weak var addArrQuestionsButton: UIButton!
    @IBOutlet weak var addQuestionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = 10
        startButton.layer.borderWidth = 3
        startButton.layer.borderColor = UIColor.systemPurple.cgColor
        
        scoreButton.layer.cornerRadius = 10
        scoreButton.layer.borderWidth = 3
        scoreButton.layer.borderColor = UIColor.systemPurple.cgColor
        
        settingButton.layer.cornerRadius = 10
        settingButton.layer.borderWidth = 3
        settingButton.layer.borderColor = UIColor.systemPurple.cgColor
        
        addQuestionButton.layer.cornerRadius = 10
        addQuestionButton.layer.borderWidth = 3
        addQuestionButton.layer.borderColor = UIColor.systemPurple.cgColor
        
        addArrQuestionsButton.layer.cornerRadius = 10
        addArrQuestionsButton.layer.borderWidth = 3
        addArrQuestionsButton.layer.borderColor = UIColor.systemPurple.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let shared = Game.shared
//        print(shared.percent)
        if let score = shared.gameSession?.score {
            statisticLabel.alpha = 1
            statisticLabel.text = "Последний результат: \(score)"
        } else {
            statisticLabel.alpha = 0
        }
    }


    
}


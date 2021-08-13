//
//  ResolutionViewController.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 11.08.2021.
//

import UIKit

//protocol ResolutionViewControllerDelegate: AnyObject {
//    func getNextQuestion(questionStrategy: QuestionsStrategy)
//}

protocol ResolutionViewControllerDelegate: AnyObject{
    func setNewStatistic(correctCount: Int, score: Int, hallHelpIsEnabled: Bool, fiftyFiftyIsEnabled: Bool, friendHelpIsEnabled: Bool)
}

class ResolutionViewController: UIViewController {

    weak var delegate: ResolutionViewControllerDelegate?
    
    var gameSession: GameSession? = nil
    let singleton = Game.shared
    
    var score = 0
    
    var currentQuestionCounter = Observable(1)
    var countQuestion = Observable(0)
    
    var isGameOver = false
    var isRigth = false
    var clueFiftyFiftyIsUsed = false
    var clueHallHelpIsUsed = false
    var clueCallFriendIsUsed = false
    
    
    @IBOutlet weak var gameOverImageView: UIImageView!
    
    @IBOutlet weak var resolutionLabel: UILabel!
    
    @IBOutlet weak var scoreCurrentGameLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextButton.layer.cornerRadius = 10
        nextButton.layer.borderWidth = 3
        nextButton.layer.borderColor = UIColor.systemPurple.cgColor
       
        gameOverImageView.image = nil
        
        gameOverImageView.frame.size.height = 0
        
        resolutionLabel.text = isRigth ? "Верно!" : "Не верно!"
            
        if !isRigth {
            gameOverImageView.transform = .identity
            gameOverImageView.image = #imageLiteral(resourceName: "game_over")
        }
        
        if isGameOver && isRigth {
            gameOverImageView.transform = .identity
            gameOverImageView.image = #imageLiteral(resourceName: "сup")
            resolutionLabel.text = "Вы выйграли"
        }
        
        if isGameOver {
            
            nextButton.setTitle("Завершить", for: .normal)
            
            
            
//                singleton.gameSession = self.gameSession
            
            let record = Record(date: Date(), score: score)
            singleton.addRecord(record: record)
        }
        scoreCurrentGameLabel.text = "Счет: \(score)"
        
        UIView.animate(withDuration: 0.5,
                      delay: 0,
                      usingSpringWithDamping: 0.7,
                      initialSpringVelocity: 0.3,
                      options: .curveEaseOut,
                      animations: {
                        self.resolutionLabel.alpha = 1
                        self.resolutionLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                        self.resolutionLabel.transform = .identity
                      },
                      completion: { [weak self]_ in
                        UIView.animate(withDuration: 0.3,
                                      delay: 0,
                                      usingSpringWithDamping: 0.7,
                                      initialSpringVelocity: 0.3,
                                      options: .curveEaseOut,
                                      animations: {
                                        self?.scoreCurrentGameLabel.alpha = 1
                                        self?.scoreCurrentGameLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                                        
                                        self?.scoreCurrentGameLabel.transform = .identity
                                      },
                                      completion: {
                                        [weak self]_ in
                                            UIView.animate(withDuration: 0.4,
                                                        delay: 0,
                                                        usingSpringWithDamping: 0.7,
                                                        initialSpringVelocity: 0.3,
                                                        options: .curveEaseOut,
                                                        animations: {
                                                         self?.nextButton.transform = .identity
                                                        },
                                                        completion: nil)
                                                      })
                                                  })
        
        if isGameOver {
            UIView.animate(withDuration: 2,
                           delay: 0,
                           usingSpringWithDamping: 0.0,
                           initialSpringVelocity: 0.0,
                           options: .curveEaseOut,
                           animations:{
                            self.gameOverImageView.alpha = 1
                           },
                           completion: nil)
        }
        
        self.delegate = gameSession
        
        delegate?.setNewStatistic(correctCount: countQuestion.value, score: score, hallHelpIsEnabled: !self.clueHallHelpIsUsed, fiftyFiftyIsEnabled: !self.clueFiftyFiftyIsUsed, friendHelpIsEnabled: !self.clueCallFriendIsUsed)
    }
    
   
    @IBAction func nextButtonAction(_ sender: Any) {

        if isGameOver {
            let startVC = storyboard?.instantiateViewController(identifier: "startVC") as! StartVC

            self.present(startVC, animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

}

extension ResolutionViewController: GameViewControllerDelegate {
    func setNewValue(isGameOver: Bool, isRigth: Bool, gameSession: GameSession, score: Int, hallHelpIsUsed: Bool, callFriendIsUsed: Bool, fiftyFiftyIsUsed: Bool) {
        self.isRigth = isRigth
        self.isGameOver = isGameOver
        self.clueCallFriendIsUsed = callFriendIsUsed
        self.clueFiftyFiftyIsUsed = fiftyFiftyIsUsed
        self.clueHallHelpIsUsed = hallHelpIsUsed
        self.gameSession = gameSession
        self.score = score
    }
    
    
  
    
    
    
    
}

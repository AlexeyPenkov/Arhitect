//
//  GameViewController.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 06.08.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func setNewValue(isGameOver: Bool, isRigth: Bool, gameSession: GameSession, score: Int, hallHelpIsUsed: Bool, callFriendIsUsed: Bool, fiftyFiftyIsUsed: Bool)
}

class GameViewController: UIViewController {
   
    weak var delegate: GameViewControllerDelegate?
    
    var questionArray = QuestionsArray().prepareQuestionsForGame()
    
    let gameSession = GameSession()
    
    let singleton = Game.shared
    
    var questItem: Question?
    
    var currentScore = 0
    
    var currentQuestionCounter = 1
    var currentCount = 0
    
    var isGameOver = false
    
    var clueFiftyFiftyIsUsed = false
    var clueHallHelpIsUsed = false
    var clueCallFriendIsUsed = false
    
    var cluesCount = 0
    
    var difficulty: Difficulty? {
        singleton.currentDifficuly
    }
    
    private var questionStrategy: QuestionsStrategy?
    
    //Аутлеты главной вью
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var buttonA: UIButton!

    @IBOutlet weak var buttonB: UIButton!
    
    @IBOutlet weak var buttonC: UIButton!
    
    @IBOutlet weak var buttonD: UIButton!
        
    @IBOutlet weak var clueFiftyFiftyButton: UIButton!
  
    @IBOutlet weak var clueHallHelpButton: UIButton!
    
    @IBOutlet weak var clueCallFriendButton: UIButton!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionStrategy = createQuestionsStrategy()
        
        gameSession.questCount = questionArray.count
        gameSession.progress.addObserver(self, options: [.initial, .new]) { [weak self] (progress, _) in
            guard let self = self else { return }
            self.progressLabel.text = "Вопрос №\(self.currentQuestionCounter), прогресс: \(Int(progress))%"
            
        }
        buttonA.layer.cornerRadius = 10
        buttonA.layer.borderWidth = 3
        buttonA.layer.borderColor = UIColor.systemPurple.cgColor
        buttonB.layer.cornerRadius = 10
        buttonB.layer.borderWidth = 3
        buttonB.layer.borderColor = UIColor.systemPurple.cgColor
        buttonC.layer.cornerRadius = 10
        buttonC.layer.borderWidth = 3
        buttonC.layer.borderColor = UIColor.systemPurple.cgColor
        buttonD.layer.cornerRadius = 10
        buttonD.layer.borderWidth = 3
        buttonD.layer.borderColor = UIColor.systemPurple.cgColor
        
        getNextQuestion()
        animationForElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    //генерация следующего вопроса
//    private func getNextQuesstion(questionStrategy: QuestionsStrategy) {
//        let questionArr = questionStrategy.getQuestion(arrQuestion: self.questionArray)
//        self.questItem = questionArr.first
//        configVC(questionArr: questionArr)
//
//    }
    
    //анимация отображения вопросов
    private func animationForElements() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.5,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations:{
                        self.questionLabel.alpha = 1
                       },
                       completion: { [weak self]_ in
                        UIView.animate(withDuration: 0.3,
                                       delay: 0.2,
                                      usingSpringWithDamping: 0.9,
                                      initialSpringVelocity: 0.1,
                                      options: .curveEaseOut,
                                      animations: {
                                       self?.buttonA.transform = .identity
                                      },
                                      completion: { [weak self]_ in
                                        UIView.animate(withDuration: 0.3,
                                                       delay: 0.2,
                                                      usingSpringWithDamping: 0.9,
                                                      initialSpringVelocity: 0.1,
                                                      options: .curveEaseOut,
                                                      animations: {
                                                       self?.buttonB.transform = .identity
                                                      },
                                                      completion: {
                                                    [weak self]_ in
                                                        UIView.animate(withDuration: 0.3,
                                                                       delay: 0.2,
                                                                    usingSpringWithDamping: 0.9,
                                                                    initialSpringVelocity: 0.1,
                                                                    options: .curveEaseOut,
                                                                    animations: {
                                                                     self?.buttonC.transform = .identity
                                                                    },
                                                                    completion: {
                                                                        [weak self]_ in
                                                                        UIView.animate(withDuration: 0.3,
                                                                                       delay: 0.2,
                                                                                        usingSpringWithDamping: 0.9,
                                                                                        initialSpringVelocity: 0.1,
                                                                                        options: .curveEaseOut,
                                                                                        animations: {
                                                                                        self?.buttonD.transform = .identity
                            
                                                                                        },
                                                                                        completion: {
                                                                                            [weak self]_ in
                                                                                            UIView.animate(withDuration: 0.5,
                                                                                                            delay: 0,
                                                                                                            usingSpringWithDamping: 0.9,
                                                                                                            initialSpringVelocity: 0.1,
                                                                                                            options: .curveEaseOut,
                                                                                                            animations: {
                                                                                                                self?.setCluesAlpha()
                                                
                                                                                                            },
                                                                                                            completion: nil)})})
                                                                  })
                                                  })})
        
    }
    
    //установка доступности подсказок
    private func setCluesAlpha() {
        clueFiftyFiftyButton.alpha = 1
        clueHallHelpButton.alpha = 1
        clueCallFriendButton.alpha = 1
        clueFiftyFiftyButton.isEnabled = !clueFiftyFiftyIsUsed
        clueHallHelpButton.isEnabled = !clueHallHelpIsUsed
        clueCallFriendButton.isEnabled = !clueCallFriendIsUsed
    }
    
    private func configVC(questionArr: [Question]) {
        
        guard let questItem = questionArr.first else { return }
         
        questionLabel.text = questItem.question
        
        var responces: [String] = questItem.responce
        
        var randomInt = Int.random(in: 0..<4)
        
        buttonA.setTitle("   A: \(responces[randomInt])", for: .normal)
        responces.remove(at: randomInt)
        
        randomInt = Int.random(in: 0..<3)
        buttonB.setTitle("   B: \(responces[randomInt])", for: .normal)
        responces.remove(at: randomInt)
        
        randomInt = Int.random(in: 0..<2)
        buttonC.setTitle("   C: \(responces[randomInt])", for: .normal)
        responces.remove(at: randomInt)
        
        buttonD.setTitle("   D: \(responces[0])", for: .normal)
        
    }
    
    //установка стартовых позиций элементов
    private func setStartPositionElements() {
        buttonA.transform = CGAffineTransform(translationX: buttonA.frame.origin.x, y: +view.bounds.height)
        buttonB.transform = CGAffineTransform(translationX: buttonA.frame.origin.x, y: +view.bounds.height)
        buttonC.transform = CGAffineTransform(translationX: buttonA.frame.origin.x, y: +view.bounds.height)
        buttonD.transform = CGAffineTransform(translationX: buttonA.frame.origin.x, y: +view.bounds.height)
        questionLabel.alpha = 0
        
        clueHallHelpButton.alpha = 0
        clueFiftyFiftyButton.alpha = 0
        clueCallFriendButton.alpha = 0
        
        buttonA.isEnabled = true
        buttonB.isEnabled = true
        buttonC.isEnabled = true
        buttonD.isEnabled = true
        buttonA.alpha = 1
        buttonB.alpha = 1
        buttonC.alpha = 1
        buttonD.alpha = 1
    }
    
    //отображения вью с результатом ответа на вопрос
    private func showResolutionView(isRigth: Bool) {
        
        let resolutionVC = storyboard?.instantiateViewController(identifier: "resolutionVC") as! ResolutionViewController
        
        self.delegate = resolutionVC
        
        if questionArray.count == 1 && isRigth {
            isGameOver = true
        }
        

        self.delegate?.setNewValue(isGameOver: isGameOver, isRigth: isRigth, gameSession: gameSession, score: currentScore, hallHelpIsUsed: clueHallHelpIsUsed, callFriendIsUsed: clueCallFriendIsUsed, fiftyFiftyIsUsed: clueFiftyFiftyIsUsed)

        
        guard let questItem = self.questItem else { return }
        var index = 0
        while index < self.questionArray.count {
            if self.questionArray[index].question == questItem.question {
                self.questionArray.remove(at: index)
            }
            index += 1
        }
        
        self.present(resolutionVC, animated: true, completion: nil)
        if self.questionArray.count != 0 {
            getNextQuestion()
        }
    }
    
    //проверка ответа
    private func checkResponce(responce: String) {
        
        guard let questItem = self.questItem else { return }
        
        let responce = getResponceInButtonTitle(responce: responce)
        
        if responce.lowercased() == questItem.correctResponse.lowercased() {
            print("Верно")
            if questionArray.count == 1 {
                isGameOver = true
            }
            currentScore += 10
            currentCount += 1
            showResolutionView(isRigth: true)
            clueHallHelpButton.alpha = 0
            clueFiftyFiftyButton.alpha = 0
            clueCallFriendButton.alpha = 0
        } else {
            print("Не угадал")
            isGameOver = true
            showResolutionView(isRigth: false)
            clueHallHelpButton.alpha = 0
            clueFiftyFiftyButton.alpha = 0
            clueCallFriendButton.alpha = 0
        }
    }
    
    private func getResponceInButtonTitle(responce: String?) -> String {
        guard var text = responce else { return ""}
        for _ in 0..<6 {
            text.removeFirst()
        }
        
        return text
    }
    
    private func createQuestionsStrategy() -> QuestionsStrategy {
        switch difficulty {
        case .easy:
            return OrderQuestionbStrategy()
        case .hard:
            return RandomQuestionStrategy()
        case .none:
            return OrderQuestionbStrategy()
        }
    }

    @IBAction func buttonAAction(_ sender: Any) {
        guard let title = buttonA.title(for: .normal) else { return }
        checkResponce(responce: title)
    }
    
    @IBAction func buttonBAction(_ sender: Any) {
        guard let title = buttonB.title(for: .normal) else { return }
        checkResponce(responce: title)
    }
    
    @IBAction func buttonCAction(_ sender: Any) {
        guard let title = buttonC.title(for: .normal) else { return }
        checkResponce(responce: title)
    }
    
    @IBAction func buttonDAction(_ sender: Any) {
        guard let title = buttonD.title(for: .normal) else { return }
        checkResponce(responce: title)
    }
    
    //Подсказки
    
    @IBAction func clueFiftyFiftyAction(_ sender: Any) {
        clueFiftyFiftyIsUsed = true
        cluesCount += 1
        clueFiftyFiftyButton.isEnabled = !clueFiftyFiftyIsUsed

        guard let responceArr = gameSession.hintUsageFacade.use50to50Hint() else { return }
        
        let responce1 = buttonA.title(for: .normal)
        let responce2 = buttonB.title(for: .normal)
        let responce3 = buttonC.title(for: .normal)
        let responce4 = buttonD.title(for: .normal)
       
        if responceArr.contains(getResponceInButtonTitle(responce: responce1)) {
            buttonA.isEnabled = false
            buttonA.alpha = 0.5
        }
        
        if responceArr.contains(getResponceInButtonTitle(responce: responce2)) {
            buttonB.isEnabled = false
            buttonB.alpha = 0.5
        }
        
        if responceArr.contains(getResponceInButtonTitle(responce: responce3)) {
            buttonC.isEnabled = false
            buttonC.alpha = 0.5
        }
        
        if responceArr.contains(getResponceInButtonTitle(responce: responce4)) {
            buttonD.isEnabled = false
            buttonD.alpha = 0.5
        }
    
    }
    
    @IBAction func clueHallHelpAction(_ sender: Any) {
        clueHallHelpIsUsed = true
        cluesCount += 1
        clueHallHelpButton.isEnabled = !clueHallHelpIsUsed

        let clueVC = storyboard?.instantiateViewController(identifier: "clueVC") as! CluesViewController
        
        clueVC.setElements(image: #imageLiteral(resourceName: "hall_help"), labelText: gameSession.hintUsageFacade.useAuditoryHelp())

        self.present(clueVC, animated: true, completion: nil)

    }
    
    
    @IBAction func clueCallFriendAction(_ sender: Any) {
        clueCallFriendIsUsed = true
        cluesCount += 1
        clueCallFriendButton.isEnabled = !clueCallFriendIsUsed
 
        let clueVC = storyboard?.instantiateViewController(identifier: "clueVC") as! CluesViewController
        
        clueVC.setElements(image: #imageLiteral(resourceName: "call_friend"), labelText: gameSession.hintUsageFacade.callFriend())
        
        self.present(clueVC, animated: true, completion: nil)
    }
}

extension GameViewController {
  
    //генерация следующего вопроса
    func getNextQuestion() {
        guard let strategy = self.questionStrategy as? QuestionsStrategy else { return }
        let questionArr = strategy.getQuestion(arrQuestion: self.questionArray)
        self.questItem = questionArr.first
        currentQuestionCounter += 1
        gameSession.hintUsageFacade.question = self.questItem
        configVC(questionArr: questionArr)
        setStartPositionElements()
        animationForElements()
    }
    
}



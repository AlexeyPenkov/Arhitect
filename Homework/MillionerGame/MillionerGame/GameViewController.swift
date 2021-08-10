//
//  GameViewController.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 06.08.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject{
    func setNewValue(correctCount: Int, score: Int, hallHelpIsEnabled: Bool, fiftyFiftyIsEnabled: Bool, friendHelpIsEnabled: Bool)
}

class GameViewController: UIViewController {
   
    weak var delegate: GameViewControllerDelegate?
    
    var questionArray = [Question]()
    
    let gameSession = GameSession()
    
    let singleton = Game.shared
    
    var indexQuestion: Int?
    
    var currentScore = 0
    var currentCount = 0
    
    var isGameOver = false
    
    var clueFiftyFiftyIsUsed = false
    var clueHallHelpIsUsed = false
    var clueCallFriendIsUsed = false
    
    var cluesCount = 0
    
    
    //Аутлеты главной вью
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var buttonA: UIButton!

    @IBOutlet weak var buttonB: UIButton!
    
    @IBOutlet weak var buttonC: UIButton!
    
    @IBOutlet weak var buttonD: UIButton!
        
    @IBOutlet weak var clueFiftyFiftyButton: UIButton!
  
    @IBOutlet weak var clueHallHelpButton: UIButton!
    
    @IBOutlet weak var clueCallFriendButton: UIButton!
    
    //Аутлеты всплывающей вью
    
    @IBOutlet weak var gameOverImageView: UIImageView!
    
    @IBOutlet weak var resolutionLabel: UILabel!
    
    @IBOutlet weak var scoreCurrentGameLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var resolutionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        prepareQuestionsForGame()
        
        getNextQuesstion()
        setStartPositionElements()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationForElements()
    }
    
    //генерация следующего вопроса
    private func getNextQuesstion() {
        let randomIndexQuestion = Int.random(in: 0..<questionArray.count)
        configVC(indexQuestion: randomIndexQuestion)
    }
    
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
                                      delay: 0,
                                      usingSpringWithDamping: 0.9,
                                      initialSpringVelocity: 0.1,
                                      options: .curveEaseOut,
                                      animations: {
                                       self?.buttonA.transform = .identity
                                      },
                                      completion: { [weak self]_ in
                                        UIView.animate(withDuration: 0.3,
                                                      delay: 0,
                                                      usingSpringWithDamping: 0.9,
                                                      initialSpringVelocity: 0.1,
                                                      options: .curveEaseOut,
                                                      animations: {
                                                       self?.buttonB.transform = .identity
                                                      },
                                                      completion: {
                                                    [weak self]_ in
                                                        UIView.animate(withDuration: 0.3,
                                                                    delay: 0,
                                                                    usingSpringWithDamping: 0.9,
                                                                    initialSpringVelocity: 0.1,
                                                                    options: .curveEaseOut,
                                                                    animations: {
                                                                     self?.buttonC.transform = .identity
                                                                    },
                                                                    completion: {
                                                                        [weak self]_ in
                                                                        UIView.animate(withDuration: 0.3,
                                                                                        delay: 0,
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
        if clueFiftyFiftyIsUsed {
            clueFiftyFiftyButton.alpha = 0.5
            clueFiftyFiftyButton.isEnabled = true
        } else {
            clueFiftyFiftyButton.alpha = 1
            clueFiftyFiftyButton.isEnabled = true
        }
        if clueHallHelpIsUsed {
            clueHallHelpButton.alpha = 0.5
            clueHallHelpButton.isEnabled = false
        } else {
            clueHallHelpButton.alpha = 1
            clueHallHelpButton.isEnabled = true
        }
        if clueCallFriendIsUsed {
            clueCallFriendButton.alpha = 0.5
            clueCallFriendButton.isEnabled = false
        } else {
            clueCallFriendButton.alpha = 1
            clueCallFriendButton.isEnabled = true
        }
    }
    
    private func configVC(indexQuestion: Int) {
        questionLabel.text = questionArray[indexQuestion].question
        
        var responces: [String] = questionArray[indexQuestion].responce
        
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
        
        self.indexQuestion = indexQuestion
    }
    
    //установка стартовых позиций элементов
    private func setStartPositionElements() {
        buttonA.transform = CGAffineTransform(translationX: buttonA.frame.origin.x, y: +view.bounds.height)
        buttonB.transform = CGAffineTransform(translationX: buttonA.frame.origin.x, y: +view.bounds.height)
        buttonC.transform = CGAffineTransform(translationX: buttonA.frame.origin.x, y: +view.bounds.height)
        buttonD.transform = CGAffineTransform(translationX: buttonA.frame.origin.x, y: +view.bounds.height)
        questionLabel.alpha = 0
        
        resolutionView.transform = CGAffineTransform(translationX: resolutionView.frame.origin.x, y: +view.bounds.height)
        gameOverImageView.alpha = 0
        
        resolutionLabel.alpha = 0
        scoreCurrentGameLabel.alpha = 0
        nextButton.transform = CGAffineTransform(translationX: buttonA.frame.origin.x, y: +view.bounds.height)
        
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
    
    //заполнение массива вопросов
    private func prepareQuestionsForGame() {
        
        //1
        var question = Question(question: "Что бросают, когда нуждаются в этом, и поднимают, когда в этом нет нужды?",
                                responce: ["Окурок",
                                "Пить",
                                "Якорь",
                                "Монетку"],
                                correctResponse: "Якорь",
                                friendHelp: "Якорь",
                                hallHelp: "Окурок")
        self.questionArray.append(question)
        //2
        question = Question(question: "Что с земли легко поднимешь, но далеко не закинешь?",
                            responce: ["Пух",
                            "Камень",
                            "Палку",
                            "Чувство собственного достоинства"],
                            correctResponse: "Пух",
                            friendHelp: "Чувство собственного достоинства",
                            hallHelp: "Пух")
        self.questionArray.append(question)
        //3
        question = Question(question: "Что становится больше, если его поставить вверх ногами?",
                            responce: ["Кран",
                            "Небосреб",
                            "Число 6",
                            "Лестница"],
                            correctResponse: "Число 6",
                            friendHelp: "Число 6",
                            hallHelp: "Число 6")
        self.questionArray.append(question)
        //4
        question = Question(question: "Вы находитесь в самолете, перед вами лошадь, сзади вас - автомобиль. Где вы находитесь?",
                            responce: ["В коме",
                            "На карусели",
                            "В больнице",
                            "В шоке"],
                            correctResponse: "На карусели",
                            friendHelp: "В больнице",
                            hallHelp: "На карусели")
        self.questionArray.append(question)
        //5
        question = Question(question: "Какое молоко никто не пил?",
                            responce: ["Кошачье",
                            "Птичье",
                            "Верблюжье",
                            "Прокисшее"],
                            correctResponse: "Птичье",
                            friendHelp: "Птичье",
                            hallHelp: "Прокисшее")
        self.questionArray.append(question)
        //6
        question = Question(question: "Под каким деревом сидит заяц, когда идет дождь?",
                            responce: ["Под осиной",
                            "Под березой",
                            "Под дубом",
                            "Под мокрым"],
                            correctResponse: "Под мокрым",
                            friendHelp: "Под осиной",
                            hallHelp: "Под мокрым")
        self.questionArray.append(question)
        //7
        question = Question(question: "Если бы осьминоги умели считать, то какой бы системой они скорее всего пользовались?",
                            responce: ["Двоичной",
                            "Восьмиричной",
                            "Десятичной",
                            "Шестнацатиричной"],
                            correctResponse: "Восьмиричной",
                            friendHelp: "Двоичной",
                            hallHelp: "Восьмиричной")
        self.questionArray.append(question)
        //8
        question = Question(question: "Закончите народную компьютерную пословицу: «Русский вирус влезет и в ...»",
                            responce: ["Окно",
                            "Выключенный компьютер",
                            "BIOS",
                            "Косынку"],
                            correctResponse: "Bios",
                            friendHelp: "Я не знаю",
                            hallHelp: "Bios")
        self.questionArray.append(question)
        //9
        question = Question(question: "Какое макаронное изделие обычно вспоминают при пожелании человеку быть здоровым, большим?",
                            responce: ["Лапша",
                            "Спагети",
                            "Паста",
                            "Макароны"],
                            correctResponse: "Лапша",
                            friendHelp: "Лапша",
                            hallHelp: "Лапша")
        self.questionArray.append(question)
        //10
        question = Question(question: "Какая часть верхней одеждой человека «страдает» в том случае, когда человек лентяйничает, бездельничает?",
                            responce: ["Кофта",
                            "Футболка",
                            "Штаны",
                            "Кеды"],
                            correctResponse: "Штаны",
                            friendHelp: "Штаны",
                            hallHelp: "Штаны")
        self.questionArray.append(question)
        
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
        
        nextButton.layer.cornerRadius = 10
        nextButton.layer.borderWidth = 3
        nextButton.layer.borderColor = UIColor.systemPurple.cgColor
        
    }
    
    //отображения вью с результатом ответа на вопрос
    private func showResolutionView(isRigth: Bool) {
        
        
        
        resolutionLabel.text = isRigth ? "Верно!" : "Не верно!"
        
        if questionArray.count == 1 && isRigth {
            isGameOver = true
            gameOverImageView.image = #imageLiteral(resourceName: "сup")
            resolutionLabel.text = "Вы выйграли"
        }
        
        if isGameOver {
            
            nextButton.setTitle("Завершить", for: .normal)
            
            self.delegate = self.gameSession
            
            delegate?.setNewValue(correctCount: currentCount, score: currentScore, hallHelpIsEnabled: !self.clueHallHelpIsUsed, fiftyFiftyIsEnabled: !self.clueFiftyFiftyIsUsed, friendHelpIsEnabled: !self.clueCallFriendIsUsed)
            
            singleton.gameSession = self.gameSession
            
            let record = Record(date: Date(), score: currentScore)
            singleton.addRecord(record: record)
        }
        scoreCurrentGameLabel.text = "Счет: \(currentScore)"
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.0,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations:{
                        self.resolutionView.alpha = 1
                        self.resolutionView.transform = .identity
                       },
                       completion: { [weak self]_ in
                        UIView.animate(withDuration: 0.5,
                                      delay: 0,
                                      usingSpringWithDamping: 0.7,
                                      initialSpringVelocity: 0.3,
                                      options: .curveEaseOut,
                                      animations: {
                                        self?.resolutionLabel.alpha = 1
                                        self?.resolutionLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                                        self?.resolutionLabel.transform = .identity
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
                                                  })})
        
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
    }
    
    //проверка ответа
    private func checkResponce(responce: String) {
        
        guard let indexQuestion = self.indexQuestion else { return }
        
        let responce = getResponceInButtonTitle(responce: responce)
        
        if responce.lowercased() == questionArray[indexQuestion].correctResponse.lowercased() {
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
    
    func checkResponseForClue(response: String) -> Bool {
        guard let indexQuestion = self.indexQuestion else { return false }
        
        if response.lowercased() == questionArray[indexQuestion].correctResponse.lowercased() {
            return true
        } else {
            return false
        }
    }
    
    func getResponceInButtonTitle(responce: String) -> String {
        var text = responce
        for _ in 0..<6 {
            text.removeFirst()
        }
        
        return text
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
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if isGameOver {
            dismiss(animated: true, completion: nil)
        } else {
            guard let indexQuestion = indexQuestion else { return }
            questionArray.remove(at: indexQuestion)
            UIView.animate(withDuration: 1,
                           delay: 0.0,
                           usingSpringWithDamping: 0.0,
                           initialSpringVelocity: 0,
                           options: .curveEaseOut,
                           animations:{
                            
                            self.resolutionView.transform = CGAffineTransform(scaleX: self.resolutionView.frame.origin.x, y: +self.view.bounds.height)
                            self.resolutionView.alpha = 0
                           },
                           completion: nil)
            getNextQuesstion()
            setStartPositionElements()
            animationForElements()
        }
    }
    
    //Подсказки
    
    @IBAction func clueFiftyFiftyAction(_ sender: Any) {
        clueFiftyFiftyIsUsed = true
        cluesCount += 1
        clueFiftyFiftyButton.isEnabled = !clueFiftyFiftyIsUsed
        var i = 1
        while i < 3 {
            let randomInt = Int.random(in: 1 ... 4)
            
            switch randomInt {
            case 1:
                guard let responce = buttonA.title(for: .normal) else { return }
                if !checkResponseForClue(response: getResponceInButtonTitle(responce: responce)) && buttonA.isEnabled {
                    buttonA.isEnabled = false
                    buttonA.alpha = 0.5
                    i += 1
                }
            case 2:
                guard let responce = buttonB.title(for: .normal) else { return }
                if !checkResponseForClue(response: getResponceInButtonTitle(responce: responce)) && buttonB.isEnabled {
                    buttonB.isEnabled = false
                    buttonB.alpha = 0.5
                    i += 1
                }
            case 3:
                guard let responce = buttonC.title(for: .normal) else { return }
                if !checkResponseForClue(response: getResponceInButtonTitle(responce: responce)) && buttonC.isEnabled {
                    buttonC.isEnabled = false
                    buttonC.alpha = 0.5
                    i += 1
                }
            case 4:
                guard let responce = buttonD.title(for: .normal) else { return }
                if !checkResponseForClue(response: getResponceInButtonTitle(responce: responce)) && buttonD.isEnabled {
                    buttonD.isEnabled = false
                    buttonD.alpha = 0.5
                    i += 1
                }
            default:
                print("Error")
            }
        }
        
        
    }
    
    @IBAction func clueHallHelpAction(_ sender: Any) {
        clueHallHelpIsUsed = true
        cluesCount += 1
        clueHallHelpButton.isEnabled = !clueHallHelpIsUsed
        guard let indexQuestion = indexQuestion else { return }
        
        let clueVC = storyboard?.instantiateViewController(identifier: "clueVC") as! CluesViewController
        
        clueVC.setElements(image: #imageLiteral(resourceName: "hall_help"), labelText: questionArray[indexQuestion].hallHelp)
        
        self.present(clueVC, animated: true, completion: nil)

    }
    
    
    @IBAction func clueCallFriendAction(_ sender: Any) {
        clueCallFriendIsUsed = true
        cluesCount += 1
        clueCallFriendButton.isEnabled = !clueCallFriendIsUsed
        
        guard let indexQuestion = indexQuestion else { return }
        
        
        
        let clueVC = storyboard?.instantiateViewController(identifier: "clueVC") as! CluesViewController
        
        clueVC.setElements(image: #imageLiteral(resourceName: "call_friend"), labelText: questionArray[indexQuestion].friendHelp)
    
      
        
        self.present(clueVC, animated: true, completion: nil)
    }
}




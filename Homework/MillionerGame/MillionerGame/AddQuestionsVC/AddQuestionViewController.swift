//
//  AddQuestionViewController.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 12.08.2021.
//

import UIKit

class AddQuestionViewController: UIViewController {

    @IBOutlet weak var questionTextField: UITextField!
    
    
    @IBOutlet weak var correctResponceTextField: UITextField!
    
    @IBOutlet weak var responceATextField: UITextField!
    
    @IBOutlet weak var responceBTextField: UITextField!
    
    @IBOutlet weak var responceCTextField: UITextField!
   
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    private let questionCaretaker = QuestionCaretaker()
    private var responceArray = [String]()
    private var correctResponce: String?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.layer.cornerRadius = 10
        addButton.layer.borderWidth = 3
        addButton.layer.borderColor = UIColor.systemPurple.cgColor
        
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderWidth = 3
        cancelButton.layer.borderColor = UIColor.systemPurple.cgColor
    }
    
    private func showAlert(alertText: String) {
        let alertController = UIAlertController(title: "Ахтунг!", message: alertText, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
    
    private func getRandomResponceClue() -> String {
        let randomInt = Int.random(in: 0...3)
        let response = responceArray[randomInt]
        
        return response
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        guard let questText = questionTextField.text,
              !questText.isEmpty,
              let questCorrectResponce = correctResponceTextField.text,
              !questCorrectResponce.isEmpty,
              let questResponceA = responceATextField.text,
              !questResponceA.isEmpty,
              let questResponceB = responceBTextField.text,
              !questResponceB.isEmpty,
              let questResponceC = responceCTextField.text,
              !questResponceC.isEmpty else {
                showAlert(alertText: "Не все поля заполнены!")
            return
        }
        correctResponce = correctResponceTextField.text
        responceArray.append(questResponceA)
        responceArray.append(questResponceC)
        responceArray.append(questResponceB)
        responceArray.append(questCorrectResponce)
        
        let question = Question(question: questText, responce: responceArray, correctResponse: questCorrectResponce, friendHelp: getRandomResponceClue(), hallHelp: getRandomResponceClue())
        
        var questionArray: [Question] = []
        
        if  let savedQuestion = questionCaretaker.loadQuestions() {
            if savedQuestion.count > 0 {
                questionArray = questionArray + savedQuestion
            }
        }
        
        questionArray.append(question)
        questionCaretaker.saveQuestions(question: questionArray)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
   
    
}

//
//  BuilderQuestionArray.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 12.08.2021.
//

import Foundation

class BuilderQuestionArray {
    
    let arrayCell: [AddQuestionsTableViewCell]
    
    let questionCaretacer = QuestionCaretaker()
    
    var questionArray: [Question] = []
    
    init(arrayCell: [AddQuestionsTableViewCell]) {
        self.arrayCell = arrayCell
    }
    
    func saveQuestionArray() {
        
        createQuestionArray()
        
        if  let savedQuestion = questionCaretacer.loadQuestions() {
            if savedQuestion.count > 0 {
                self.questionArray = self.questionArray + savedQuestion
            }
        }
        
        questionCaretacer.saveQuestions(question: questionArray)
    }
    
    func createQuestionArray() {
        for item in arrayCell {
            if let question = getQuestionFromeCell(item: item) {
                questionArray.append(question)
            }
        }
    }
    
    func getQuestionFromeCell(item: AddQuestionsTableViewCell) -> Question? {
        let questBuilder = BuilderQuestionFromCell()
        questBuilder.setQuestionText(item.questionTextField.text)
        questBuilder.setCorrectResponceText(item.correctResponceTextField.text)
        questBuilder.setResponceA(item.responceATextField.text)
        questBuilder.setResponceB(item.responceBTextField.text)
        questBuilder.setResponceC(item.responceCTextField.text)
        questBuilder.setResponceArray()
        return questBuilder.build()
    }
}

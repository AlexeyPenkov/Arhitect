//
//  BuilderQuestionFromCell.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 12.08.2021.
//

import Foundation

class BuilderQuestionFromCell {
    
    private(set) var responceArray: [String] = []
    
    private(set) var question: String = ""
    private(set) var correctResponse: String = ""
    private(set) var responceA: String = ""
    private(set) var responceB: String = ""
    private(set) var responceC: String = ""
    
    
    func setQuestionText(_ question: String?) {
        guard let question = question else { return }
        self.question = question
    }
    
    func setCorrectResponceText(_ correctResponse: String?) {
        guard let correctResponse = correctResponse else { return }
        self.correctResponse = correctResponse
    }
    
    func setResponceA(_ responceA: String?) {
        guard let responceA = responceA else { return }
        self.responceA = responceA
    }
    
    func setResponceB(_ responceB: String?) {
        guard let responceB = responceB else { return }
        self.responceB = responceB
    }
    
    func setResponceC(_ responceC: String?) {
        guard let responceC = responceC else { return }
        self.responceC = responceC
    }
    
    func setResponceArray() {
        
        self.responceArray.append(self.correctResponse)
        self.responceArray.append(self.responceA)
        self.responceArray.append(self.responceB)
        self.responceArray.append(self.responceC)
    }
    
    func build() -> Question? {
        
        return Question(question: question, responce: responceArray, correctResponse: correctResponse, friendHelp: getRandomResponceClue(), hallHelp: getRandomResponceClue())
    }
    
    private func getRandomResponceClue() -> String {
        let randomInt = Int.random(in: 0...3)
        let response = self.responceArray[randomInt]
        
        return response
    }
}

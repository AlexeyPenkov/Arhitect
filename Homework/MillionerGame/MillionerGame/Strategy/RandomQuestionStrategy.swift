//
//  RandomQuestionStrategy.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 11.08.2021.
//

import UIKit

class RandomQuestionStrategy: QuestionsStrategy {
    func getQuestion(arrQuestion: [Question]) -> [Question] {
        let randomIndex = Int.random(in: 0 ..< arrQuestion.count)
        
        return [arrQuestion[randomIndex]]
    }
    
    
}

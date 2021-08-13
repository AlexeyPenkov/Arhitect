//
//  QuestionsStrategy.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 11.08.2021.
//

import Foundation

protocol QuestionsStrategy: AnyObject {
    func getQuestion(arrQuestion: [Question]) -> [Question]
}

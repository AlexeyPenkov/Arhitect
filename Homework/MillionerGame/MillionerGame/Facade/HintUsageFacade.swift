//
//  HintUsageFacade.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 13.08.2021.
//

import Foundation

class HintUsageFacade {
    var question: Question?
    
    func callFriend() -> String {
        var responce = ""
        guard let question = question else { return responce }
        responce = question.friendHelp
        return responce
    }
    
    func useAuditoryHelp() -> String {
        var responce = ""
        guard let question = question else { return responce}
        responce = question.hallHelp
        return responce
    }
    
    func use50to50Hint() -> [String]? {
        guard let question = question else { return nil }
        var questArray: [String] = []
        var currResponce = ""
        var i = 1
        while i < 3 {
            let randomInt = Int.random(in: 0 ... 3)
            let responce = question.responce[randomInt]
            if !checkResponseForClue(response: responce) && responce != currResponce {
                questArray.append(responce)
                currResponce = responce
                i += 1
            }
        }
        return questArray
    }
        
    func checkResponseForClue(response: String) -> Bool {
        guard  let question = question else { return false }
        
        if response.lowercased() == question.correctResponse.lowercased() {
            return true
        } else {
            return false
        }
    }
}


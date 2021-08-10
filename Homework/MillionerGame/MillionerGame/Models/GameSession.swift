//
//  GameSession.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 07.08.2021.
//

import Foundation

class GameSession {
    
    var questCount: Int = 0
    var correctResponseCount: Int = 0
    var score: Int = 0
    
    var hallHelpIsEnabled = true
    var fiftyFiftyHelpisEnabled = true
    var friendHelpIsEnabled = true

}

extension GameSession: GameViewControllerDelegate {
    func setNewValue(correctCount: Int, score: Int, hallHelpIsEnabled: Bool, fiftyFiftyIsEnabled: Bool, friendHelpIsEnabled: Bool) {
        self.questCount = 10
        self.correctResponseCount = correctCount
        self.score = score
        self.fiftyFiftyHelpisEnabled = fiftyFiftyIsEnabled
        self.hallHelpIsEnabled = hallHelpIsEnabled
        self.friendHelpIsEnabled = friendHelpIsEnabled
    }
    
    
}

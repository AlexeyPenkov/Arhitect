//
//  GameSession.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 07.08.2021.
//

import Foundation

class GameSession {
    
    var questCount: Int = 0
    var correctResponseCount = Observable(0)
    var score: Int = 0
    var progress = Observable(0.0)
    
    var hallHelpIsEnabled = true
    var fiftyFiftyHelpisEnabled = true
    var friendHelpIsEnabled = true
    
    let hintUsageFacade = HintUsageFacade()

}



extension GameSession: ResolutionViewControllerDelegate {
    
    func setNewStatistic(correctCount: Int, score: Int, hallHelpIsEnabled: Bool, fiftyFiftyIsEnabled: Bool, friendHelpIsEnabled: Bool) {
        //self.questCount = 10
        self.correctResponseCount.value += 1
        self.score = score
        self.fiftyFiftyHelpisEnabled = fiftyFiftyIsEnabled
        self.hallHelpIsEnabled = hallHelpIsEnabled
        self.friendHelpIsEnabled = friendHelpIsEnabled

        self.progress.value = Double(self.correctResponseCount.value)/Double(self.questCount)*100
    }
    
    
}

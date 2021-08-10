//
//  Game.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 07.08.2021.
//

import Foundation

class Game {
    static let shared = Game()
    
    private let recordCaretaker = RecordsCaretaker()
    
    private(set) var records: [Record] = [] {
        didSet {
            recordCaretaker.saveRecords(records: records)
        }
    }
    
    private init() {
        records = recordCaretaker.loadRecords() ?? []
    }
    
    var gameSession: GameSession?
    
    var percent: Double? {
        guard let correctCount = gameSession?.correctResponseCount,
              let questCount = gameSession?.questCount else {
            return 0.0
        }
        return Double(correctCount*100)/Double(questCount)
    }
    
    func addRecord(record: Record) {
        records.append(record)
    }
    
    func clearRecords() {
        records.removeAll()
    }
}

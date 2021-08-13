//
//  RecordsMemento.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 09.08.2021.
//

import Foundation

class QuestionCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "question"
    
    func saveQuestions(question: [Question]){
        do {
            let data = try encoder.encode(question)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadQuestions() -> [Question]? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        
        do {
            return try decoder.decode([Question].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

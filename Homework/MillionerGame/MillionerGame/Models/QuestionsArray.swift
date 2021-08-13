//
//  QuestionsArray.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 11.08.2021.
//

import UIKit



class QuestionsArray {
    
    //заполнение массива вопросов
    func prepareQuestionsForGame() -> [Question] {
       
        var questionArray = [Question]()
        
        //1
        var question = Question(question: "Что бросают, когда нуждаются в этом, и поднимают, когда в этом нет нужды?",
                                responce: ["Окурок",
                                "Пить",
                                "Якорь",
                                "Монетку"],
                                correctResponse: "Якорь",
                                friendHelp: "Якорь",
                                hallHelp: "Окурок")
        questionArray.append(question)
        //2
        question = Question(question: "Что с земли легко поднимешь, но далеко не закинешь?",
                            responce: ["Пух",
                            "Камень",
                            "Палку",
                            "Чувство собственного достоинства"],
                            correctResponse: "Пух",
                            friendHelp: "Чувство собственного достоинства",
                            hallHelp: "Пух")
        questionArray.append(question)
        //3
        question = Question(question: "Что становится больше, если его поставить вверх ногами?",
                            responce: ["Кран",
                            "Небосреб",
                            "Число 6",
                            "Лестница"],
                            correctResponse: "Число 6",
                            friendHelp: "Число 6",
                            hallHelp: "Число 6")
        questionArray.append(question)
        //4
        question = Question(question: "Вы находитесь в самолете, перед вами лошадь, сзади вас - автомобиль. Где вы находитесь?",
                            responce: ["В коме",
                            "На карусели",
                            "В больнице",
                            "В шоке"],
                            correctResponse: "На карусели",
                            friendHelp: "В больнице",
                            hallHelp: "На карусели")
        questionArray.append(question)
        //5
        question = Question(question: "Какое молоко никто не пил?",
                            responce: ["Кошачье",
                            "Птичье",
                            "Верблюжье",
                            "Прокисшее"],
                            correctResponse: "Птичье",
                            friendHelp: "Птичье",
                            hallHelp: "Прокисшее")
        questionArray.append(question)
        //6
        question = Question(question: "Под каким деревом сидит заяц, когда идет дождь?",
                            responce: ["Под осиной",
                            "Под березой",
                            "Под дубом",
                            "Под мокрым"],
                            correctResponse: "Под мокрым",
                            friendHelp: "Под осиной",
                            hallHelp: "Под мокрым")
        questionArray.append(question)
        //7
        question = Question(question: "Если бы осьминоги умели считать, то какой бы системой они скорее всего пользовались?",
                            responce: ["Двоичной",
                            "Восьмиричной",
                            "Десятичной",
                            "Шестнацатиричной"],
                            correctResponse: "Восьмиричной",
                            friendHelp: "Двоичной",
                            hallHelp: "Восьмиричной")
        questionArray.append(question)
        //8
        question = Question(question: "Закончите народную компьютерную пословицу: «Русский вирус влезет и в ...»",
                            responce: ["Окно",
                            "Выключенный компьютер",
                            "BIOS",
                            "Косынку"],
                            correctResponse: "Bios",
                            friendHelp: "Я не знаю",
                            hallHelp: "Bios")
        questionArray.append(question)
        //9
        question = Question(question: "Какое макаронное изделие обычно вспоминают при пожелании человеку быть здоровым, большим?",
                            responce: ["Лапша",
                            "Спагети",
                            "Паста",
                            "Макароны"],
                            correctResponse: "Лапша",
                            friendHelp: "Лапша",
                            hallHelp: "Лапша")
        questionArray.append(question)
        //10
        question = Question(question: "Какая часть верхней одеждой человека «страдает» в том случае, когда человек лентяйничает, бездельничает?",
                            responce: ["Кофта",
                            "Футболка",
                            "Штаны",
                            "Кеды"],
                            correctResponse: "Штаны",
                            friendHelp: "Штаны",
                            hallHelp: "Штаны")
        questionArray.append(question)
        
        let questionCaretaker = QuestionCaretaker()
        if let questionMemento = questionCaretaker.loadQuestions() {
            if questionMemento.count > 0 {
                questionArray = questionArray + questionMemento
            }
        }
        return questionArray
        
    }
}

//
//  GameInstace.swift
//  Quiz
//
//  Created by Jakob Handke on 25.03.26.
//

import Foundation
import SwiftData

//@Model
//final class GameInstance {
//    var answeredQuestions: [Question: Answer]
//    var unansweredQuestions: [Question]
//    var playerA: String
//    var playerB: String
//
//    init(answeredQuestions: [Question: Answer], unansweredQuestions: [Question], playerA: String, playerB: String) {
//        self.answeredQuestions = answeredQuestions
//        self.unansweredQuestions = unansweredQuestions
//        self.playerA = playerA
//        self.playerB = playerB
//    }
//
//    init(from questionSet: QuestionSet, playerA: String, playerB: String) {
//        self.unansweredQuestions = questionSet.questions
//        self.answeredQuestions = [:]
//        self.playerA = playerA
//        self.playerB = playerB
//    }
//
//    var finished: Bool {
//        unansweredQuestions.isEmpty
//    }
//
//    var correctAnswers: Int {
////        answeredQuestions.values.filter(\.isCorrect).count
//        fatalError("Not implemented!")
//    }
//
//    var score: Double {
//        Double(correctAnswers) / Double(answeredQuestions.count)
//    }
//}

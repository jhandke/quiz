//
//  QuestionSet.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import Foundation
import SwiftData

@Model
final class QuestionSet: Identifiable {
    var name: String = ""
    var questions: [Question] = []

    init(name: String, questions: [Question]) {
        self.name = name
        self.questions = questions
    }
}

extension QuestionSet {
    static let example: QuestionSet = QuestionSet(name: "Testfragen", questions: [
        Question(text: "Wie heißt der Bürgermeister von Wesel?", category: "Spaß", answers: [
            Answer(text: "Esel"),
            Answer(text: "Klaus-Dieter"),
            Answer(text: "Peter Maffay")
        ], correctAnswerIndex: 2),
        Question(text: "Wie lautet die Telefonvorwahl von Lemmer?", category: "Zahlen", answers: [
            Answer(text: "0800"),
            Answer(text: "1337"),
            Answer(text: "0514")
        ], correctAnswerIndex: 2),
        Question(text: "Warum sind Bananen krumm?", category: "Biophysik", answers: [
            Answer(text: "Schwerkraft"),
            Answer(text: "Die Affen ziehen dran"),
            Answer(text: "Weil das Fruchtfleich so geformt ist")
        ], correctAnswerIndex: 0)
    ])
}

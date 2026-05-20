//
//  GivenAnswer.swift
//  Quiz
//
//  Created by Jakob Handke on 08.05.26.
//

import Foundation
import SwiftData

typealias GivenAnswer = SchemaV1.GivenAnswer

extension SchemaV1 {
    @Model
    class GivenAnswer {
        var question: Question
        var answer: Answer

        init(question: Question, answer: Answer) {
            self.question = question
            self.answer = answer
        }
    }
}

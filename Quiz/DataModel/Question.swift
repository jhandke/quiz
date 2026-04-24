//
//  Question.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import Foundation
import SwiftData

struct Question: Hashable, Equatable, Identifiable, Codable {
    var id = UUID()
    var text: String
    var category: String
    var answers: [Answer]
    var correctAnswerIndex: Int

    var correctAnswer: Answer? {
        answers[safeIndex: correctAnswerIndex]
    }

//    init(text: String, category: String, answers: [Answer]) {
//        self.text = text
//        self.category = category
//        self.answers = answers
//    }
//
//    private enum CodingKeys: String, CodingKey {
//        case text
//        case category
//        case answers
//    }

//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(text, forKey: .text)
//        try container.encode(category, forKey: .category)
//        try container.encode(answers, forKey: .answers)
//    }
//
//    convenience init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let text = try container.decode(String.self, forKey: .text)
//        let category = try container.decode(String.self, forKey: .category)
//        let answers = try container.decode([Answer].self, forKey: .answers)
//        self.init(text: text, category: category, answers: answers)
//    }
}

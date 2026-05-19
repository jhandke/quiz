//
//  Question.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Question: Hashable, Equatable, Identifiable, Codable {
    var id: UUID
    var text: String
    var category: String
    @Relationship(inverse: \Answer.question) var answers: [Answer]
    var correctAnswerUUID: UUID?

    init(id: UUID, text: String, category: String, answers: [Answer], correctAnswerUUID: UUID?) {
        self.id = id
        self.text = text
        self.category = category
        self.answers = answers
        self.correctAnswerUUID = correctAnswerUUID
    }

    convenience init(text: String, category: String, answers: [Answer], correctAnswerUUID: UUID?) {
        self.init(id: UUID(), text: text, category: category, answers: answers, correctAnswerUUID: correctAnswerUUID)
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.text = try container.decode(String.self, forKey: .text)
        self.category = try container.decode(String.self, forKey: .category)
        self.answers = try container.decode([Answer].self, forKey: .answers)
        self.correctAnswerUUID = try container.decode(UUID.self, forKey: .correcAnswerUUID)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.text, forKey: .text)
        try container.encode(self.category, forKey: .category)
        try container.encode(self.answers, forKey: .answers)
        try container.encode(self.correctAnswerUUID, forKey: .correcAnswerUUID)
    }

    var correctAnswer: Answer? {
        answers.first(where: { $0.uuid == correctAnswerUUID })
    }

    func addAnswer(_ answer: Answer) {
        self.answers.append(answer)
        if self.answers.count == 1 {
            self.correctAnswerUUID = answer.uuid
        }
    }

    func fixCorrectAnswer() {
        guard let correctAnswerUUID, !answers.contains(where: { $0.uuid == correctAnswerUUID }) else { return }
        self.correctAnswerUUID = answers.first?.uuid
    }

    @MainActor func removeAnswers(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let uuid = answers[index].uuid
        if let answer = answers[safeIndex: index] {
            answer.modelContext?.delete(answer)
        }
        if let correctAnswerUUID, correctAnswerUUID == uuid {
            self.correctAnswerUUID = answers.first?.uuid ?? nil
        }
    }
}

extension Question {
    @MainActor static let empty = Question(text: "", category: "", answers: [], correctAnswerUUID: nil)
}

extension Question {
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case category
        case answers
        case correcAnswerUUID
    }
}

extension Question {
    func clone() -> Question {
        let correctAnswer = self.answers.first(where: { $0.uuid == self.correctAnswerUUID })
        let otherAnswers = self.answers.filter { $0.uuid != self.correctAnswerUUID }
        var newAnswers = otherAnswers.map({ $0.clone() })
        var newCorrectAnswerUUID: UUID?
        if let newCorrectAnswer = correctAnswer?.clone() {
            newAnswers.append(newCorrectAnswer)
            newCorrectAnswerUUID = newCorrectAnswer.uuid
        }
        let question = Question(text: self.text, category: self.category, answers: newAnswers, correctAnswerUUID: newCorrectAnswerUUID)
        return question
    }
}

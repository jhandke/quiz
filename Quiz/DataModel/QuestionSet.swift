//
//  QuestionSet.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import Foundation
import SwiftData

@Model
final class QuestionSet: Identifiable, Hashable {
    var name: String = ""
    var questions: [Question] = []
    var finalQuestion: Question
    var lastEdit: Date = Date.now

    init(name: String, questions: [Question], finalQuestion: Question, lastEdit: Date) {
        self.name = name
        self.questions = questions
        self.finalQuestion = finalQuestion
        self.lastEdit = lastEdit
    }
}

extension QuestionSet {
    static var reduced: QuestionSet {
        var questions: [Question] = []
        var uuid = UUID()
        questions.append(Question(text: "Welches Metall ist flüssig bei Raumtemperatur?", category: "Materialkunde", answers: [
            Answer(text: "Quecksilber", uuid: uuid),
            Answer(text: "Gold"),
            Answer(text: "Aluminium")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(Question(text: "Wie viele Planeten hat unser Sonnensystem?", category: "Astronomie", answers: [
            Answer(text: "7"),
            Answer(text: "8", uuid: uuid),
            Answer(text: "9")
        ], correctAnswerUUID: uuid))
        uuid = UUID()
        let finalQuestion = Question(text: "Welcher Maler ist bekannt für das Werk 'Die Sternennacht'?", category: "Kunstgeschichte",
                                     answers: [
                                        Answer(text: "Claude Monet", uuid: UUID()),
                                        Answer(text: "Vincent van Gogh", uuid: uuid),
                                        Answer(text: "Pablo Picasso", uuid: UUID())
                                     ], correctAnswerUUID: uuid)

        return QuestionSet(
            name: "gekürze Fragen",
            questions: questions,
            finalQuestion: finalQuestion,
            lastEdit: .now.addingTimeInterval(-10000000))
    }

    static var example: QuestionSet {
        var questions: [Question] = []
        var uuid = UUID()
        questions.append(Question(text: "Welches Metall ist flüssig bei Raumtemperatur?", category: "Materialkunde", answers: [
            Answer(text: "Quecksilber", uuid: uuid),
            Answer(text: "Gold"),
            Answer(text: "Aluminium")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(Question(text: "Wie viele Planeten hat unser Sonnensystem?", category: "Astronomie", answers: [
            Answer(text: "7"),
            Answer(text: "8", uuid: uuid),
            Answer(text: "9")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(Question(text: "Welches Land hat die meisten Einwohner weltweit?", category: "Demografie", answers: [
            Answer(text: "Indien"),
            Answer(text: "USA"),
            Answer(text: "China", uuid: uuid)
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(Question(text: "Welches Tier ist das Wappentier von Berlin?", category: "Spaß", answers: [
            Answer(text: "Bär", uuid: uuid),
            Answer(text: "Eule"),
            Answer(text: "Löwe")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(Question(text: "Wie nennt man in der Musik das schnelle Wiederholen eines Tons?", category: "Musik", answers: [
            Answer(text: "Legato"),
            Answer(text: "Vibrato"),
            Answer(text: "Triller", uuid: uuid)
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(Question(text: "Welches Land gewann die Fußball-Weltmeisterschaft 2010?", category: "Sport", answers: [
            Answer(text: "Spanien", uuid: uuid),
            Answer(text: "Niederlande"),
            Answer(text: "Deutschland")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(Question(text: "In welcher Sprache wurde das Epos 'Ilias' ursprünglich verfasst?", category: "Antike", answers: [
            Answer(text: "Latein"),
            Answer(text: "Altgriechisch", uuid: uuid),
            Answer(text: "Althebräisch")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(Question(text: "Welche Einheit misst elektrische Spannung?", category: "Elektrotechnik", answers: [
            Answer(text: "Ampere"),
            Answer(text: "Volt", uuid: uuid),
            Answer(text: "Ohm")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(Question(text: "Welches Tier legt die größten Eier?", category: "Zoologie", answers: [
            Answer(text: "Strauß", uuid: uuid),
            Answer(text: "Pinguin"),
            Answer(text: "Schildkröte")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(Question(text: "Welche Farbe entsteht beim Mischen von Blau und Gelb?", category: "Kunst", answers: [
            Answer(text: "Grün", uuid: uuid),
            Answer(text: "Violett"),
            Answer(text: "Orange")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(Question(text: "Wie viele Tage hat ein Schaltjahr?", category: "Kalender", answers: [
            Answer(text: "365"),
            Answer(text: "366", uuid: uuid),
            Answer(text: "367")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions
            .append(Question(text: "Welches Vitamin wird hauptsächlich durch Sonnenlicht in der Haut gebildet?",
                             category: "Ernährung",
                             answers: [
                                Answer(text: "Vitamin C"),
                                Answer(text: "Vitamin D", uuid: uuid),
                                Answer(text: "Vitamin B12")
                             ], correctAnswerUUID: uuid))

        uuid = UUID()
        let finalQuestion = Question(text: "Welcher Maler ist bekannt für das Werk 'Die Sternennacht'?", category: "Kunstgeschichte",
                                     answers: [
                                        Answer(text: "Claude Monet", uuid: UUID()),
                                        Answer(text: "Vincent van Gogh", uuid: uuid),
                                        Answer(text: "Pablo Picasso", uuid: UUID())
                                     ], correctAnswerUUID: uuid)

        return QuestionSet(
            name: "Beispielfragen",
            questions: questions,
            finalQuestion: finalQuestion,
            lastEdit: .now.addingTimeInterval(-10000000))
    }
}

extension QuestionSet {
    @MainActor static let empty = QuestionSet(name: "", questions: [], finalQuestion: Question.empty, lastEdit: .distantPast)
}

//
//  QuestionSet.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import Foundation
import SwiftData

typealias QuestionSet = SchemaV1.QuestionSet

extension SchemaV1 {
    @Model
    final class QuestionSet: Identifiable, Hashable {
        var name: String = ""
        var questions: [SchemaV1.Question] = []
        var finalQuestion: SchemaV1.Question
        var lastEdit: Date = Date.now

        init(name: String, questions: [SchemaV1.Question], finalQuestion: SchemaV1.Question, lastEdit: Date) {
            self.name = name
            self.questions = questions
            self.finalQuestion = finalQuestion
            self.lastEdit = lastEdit
        }
    }
}

extension SchemaV1.QuestionSet {
    static var reduced: SchemaV1.QuestionSet {
        var questions: [SchemaV1.Question] = []
        var uuid = UUID()
        questions.append(SchemaV1.Question(text: "Welches Metall ist flüssig bei Raumtemperatur?", category: "Materialkunde", answers: [
            SchemaV1.Answer(text: "Quecksilber", uuid: uuid),
            SchemaV1.Answer(text: "Gold"),
            SchemaV1.Answer(text: "Aluminium")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(SchemaV1.Question(text: "Wie viele Planeten hat unser Sonnensystem?", category: "Astronomie", answers: [
            SchemaV1.Answer(text: "7"),
            SchemaV1.Answer(text: "8", uuid: uuid),
            SchemaV1.Answer(text: "9")
        ], correctAnswerUUID: uuid))
        uuid = UUID()
        let finalQuestion = SchemaV1.Question(text: "Welcher Maler ist bekannt für das Werk 'Die Sternennacht'?",
                                              category: "Kunstgeschichte",
                                              answers: [
                                                SchemaV1.Answer(text: "Claude Monet"),
                                                SchemaV1.Answer(text: "Vincent van Gogh", uuid: uuid),
                                                SchemaV1.Answer(text: "Pablo Picasso")
                                              ], correctAnswerUUID: uuid)

        return SchemaV1.QuestionSet(
            name: "gekürze Fragen",
            questions: questions,
            finalQuestion: finalQuestion,
            lastEdit: .now.addingTimeInterval(-10000000))
    }

    static var example: SchemaV1.QuestionSet {
        var questions: [SchemaV1.Question] = []
        var uuid = UUID()
        questions.append(SchemaV1.Question(text: "Welches Metall ist flüssig bei Raumtemperatur?", category: "Materialkunde", answers: [
            SchemaV1.Answer(text: "Quecksilber", uuid: uuid),
            SchemaV1.Answer(text: "Gold"),
            SchemaV1.Answer(text: "Aluminium")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(SchemaV1.Question(text: "Wie viele Planeten hat unser Sonnensystem?", category: "Astronomie", answers: [
            SchemaV1.Answer(text: "7"),
            SchemaV1.Answer(text: "8", uuid: uuid),
            SchemaV1.Answer(text: "9")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(SchemaV1.Question(text: "Welches Land hat die meisten Einwohner weltweit?", category: "Demografie", answers: [
            SchemaV1.Answer(text: "Indien"),
            SchemaV1.Answer(text: "USA"),
            SchemaV1.Answer(text: "China", uuid: uuid)
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(SchemaV1.Question(text: "Welches Tier ist das Wappentier von Berlin?", category: "Spaß", answers: [
            SchemaV1.Answer(text: "Bär", uuid: uuid),
            SchemaV1.Answer(text: "Eule"),
            SchemaV1.Answer(text: "Löwe")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions
            .append(SchemaV1.Question(text: "Wie nennt man in der Musik das schnelle Wiederholen eines Tons?", category: "Musik", answers: [
                SchemaV1.Answer(text: "Legato"),
                SchemaV1.Answer(text: "Vibrato"),
                SchemaV1.Answer(text: "Triller", uuid: uuid)
            ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(SchemaV1.Question(text: "Welches Land gewann die Fußball-Weltmeisterschaft 2010?", category: "Sport", answers: [
            SchemaV1.Answer(text: "Spanien", uuid: uuid),
            SchemaV1.Answer(text: "Niederlande"),
            SchemaV1.Answer(text: "Deutschland")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions
            .append(SchemaV1.Question(text: "In welcher Sprache wurde das Epos 'Ilias' ursprünglich verfasst?", category: "Antike",
                                      answers: [
                                        SchemaV1.Answer(text: "Latein"),
                                        SchemaV1.Answer(text: "Altgriechisch", uuid: uuid),
                                        SchemaV1.Answer(text: "Althebräisch")
                                      ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(SchemaV1.Question(text: "Welche Einheit misst elektrische Spannung?", category: "Elektrotechnik", answers: [
            SchemaV1.Answer(text: "Ampere"),
            SchemaV1.Answer(text: "Volt", uuid: uuid),
            SchemaV1.Answer(text: "Ohm")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(SchemaV1.Question(text: "Welches Tier legt die größten Eier?", category: "Zoologie", answers: [
            SchemaV1.Answer(text: "Strauß", uuid: uuid),
            SchemaV1.Answer(text: "Pinguin"),
            SchemaV1.Answer(text: "Schildkröte")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(SchemaV1.Question(text: "Welche Farbe entsteht beim Mischen von Blau und Gelb?", category: "Kunst", answers: [
            SchemaV1.Answer(text: "Grün", uuid: uuid),
            SchemaV1.Answer(text: "Violett"),
            SchemaV1.Answer(text: "Orange")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions.append(SchemaV1.Question(text: "Wie viele Tage hat ein Schaltjahr?", category: "Kalender", answers: [
            SchemaV1.Answer(text: "365"),
            SchemaV1.Answer(text: "366", uuid: uuid),
            SchemaV1.Answer(text: "367")
        ], correctAnswerUUID: uuid))

        uuid = UUID()
        questions
            .append(SchemaV1.Question(text: "Welches Vitamin wird hauptsächlich durch Sonnenlicht in der Haut gebildet?",
                                      category: "Ernährung",
                                      answers: [
                                        SchemaV1.Answer(text: "Vitamin C"),
                                        SchemaV1.Answer(text: "Vitamin D", uuid: uuid),
                                        SchemaV1.Answer(text: "Vitamin B12")
                                      ], correctAnswerUUID: uuid))

        uuid = UUID()
        let finalQuestion = SchemaV1.Question(text: "Welcher Maler ist bekannt für das Werk 'Die Sternennacht'?",
                                              category: "Kunstgeschichte",
                                              answers: [
                                                SchemaV1.Answer(text: "Claude Monet"),
                                                SchemaV1.Answer(text: "Vincent van Gogh", uuid: uuid),
                                                SchemaV1.Answer(text: "Pablo Picasso")
                                              ], correctAnswerUUID: uuid)

        return SchemaV1.QuestionSet(
            name: "Beispielfragen",
            questions: questions,
            finalQuestion: finalQuestion,
            lastEdit: .now.addingTimeInterval(-10000000))
    }
}

extension SchemaV1.QuestionSet {
    @MainActor static let empty = QuestionSet(name: "", questions: [], finalQuestion: Question.empty, lastEdit: .distantPast)
}

//
//  Answer.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import Foundation
import SwiftData
import SwiftUI

typealias Answer = SchemaV1.Answer

extension SchemaV1 {
    @Model
    class Answer: Hashable, Equatable, Codable {
        var text: String
        private(set) var createdAt: Date
        var uuid: UUID
        var question: Question?

        init(text: String, createdAt: Date, uuid: UUID) {
            self.text = text
            self.createdAt = createdAt
            self.uuid = uuid
        }

        convenience init(text: String) {
            self.init(text: text, createdAt: .now, uuid: UUID())
        }

        convenience init(text: String, uuid: UUID) {
            self.init(text: text, createdAt: .now, uuid: uuid)
        }

        required init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.text = try container.decode(String.self, forKey: .text)
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            self.uuid = try container.decode(UUID.self, forKey: .uuid)
        }

        func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(text, forKey: .text)
            try container.encode(createdAt, forKey: .createdAt)
            try container.encode(uuid, forKey: .uuid)
        }
    }
}

extension SchemaV1.Answer {
    func clone() -> Answer {
        let answer = Answer(text: self.text, createdAt: self.createdAt, uuid: self.uuid)
        return answer
    }
}

extension SchemaV1.Answer {
    enum CodingKeys: String, CodingKey {
        case text
        case createdAt
        case uuid
    }
}

extension SchemaV1.Answer {
    static let sortBindingsByDateAscending: SortDescriptor<Binding<Answer>> = SortDescriptor(\.wrappedValue.createdAt, order: .forward)
}

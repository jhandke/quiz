//
//  Answer.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import Foundation
import SwiftData

@Model
class Answer: Hashable, Equatable, Codable {
    var text: String
    var uuid: UUID

    init(text: String, uuid: UUID) {
        self.text = text
        self.uuid = uuid
    }

    convenience init(text: String) {
        self.init(text: text, uuid: UUID())
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
        self.uuid = try container.decode(UUID.self, forKey: .uuid)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try container.encode(uuid, forKey: .uuid)
    }
}

extension Answer {
    func clone() -> Answer {
        let answer = Answer(text: self.text)
        return answer
    }
}

extension Answer {
    enum CodingKeys: String, CodingKey {
        case text
        case uuid
    }
}

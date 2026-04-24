//
//  Answer.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import Foundation
import SwiftData

struct Answer: Identifiable, Hashable, Equatable, Codable {
    var id = UUID()
    var text: String

//    init(text: String, isCorrect: Bool = false) {
//        self.text = text
//        self.isCorrect = isCorrect
//    }

    var description: String {
        return "\(text)"
    }

//    // MARK: - Encodable
//    private enum CodingKeys: String, CodingKey {
//        case text
//        case isCorrect
//    }
//
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(text, forKey: .text)
//        try container.encode(isCorrect, forKey: .isCorrect)
//    }
//
//    // MARK: - Decodable
//    required init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.text = try container.decode(String.self, forKey: .text)
//        self.isCorrect = try container.decode(Bool.self, forKey: .isCorrect)
//    }
}

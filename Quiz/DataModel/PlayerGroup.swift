//
//  PlayerGroup.swift
//  Quiz
//
//  Created by Jakob Handke on 25.03.26.
//

import Foundation
import SwiftData

@Model
final class PlayerGroup {
    var name: String

    init(name: String) {
        self.name = name
    }
}

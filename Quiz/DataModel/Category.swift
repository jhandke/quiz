//
//  Category.swift
//  Quiz
//
//  Created by Jakob Handke on 21.03.26.
//

import Foundation
import SwiftData

struct Category: Identifiable {
    var id = UUID()
    var name: String = ""

    init(name: String) {
        self.name = name
    }
}

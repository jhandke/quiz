//
//  Category.swift
//  Quiz
//
//  Created by Jakob Handke on 21.03.26.
//

import Foundation

struct Category {
    let name: String
    var state: CategoryState
}

enum CategoryState {
    case unanswered
    case answered
}

//
//  Int+ASCIILetter.swift
//  Quiz
//
//  Created by Jakob Handke on 09.05.26.
//

import Foundation

extension Int {
    var capitalASCIILetter: String {
        "\(UnicodeScalar(65 + self).map(Character.init) ?? "?")"
    }
}

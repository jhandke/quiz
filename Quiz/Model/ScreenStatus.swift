//
//  ScreenStatus.swift
//  Quiz
//
//  Created by Jakob Handke on 06.03.26.
//

import Foundation

class ScreenStatus {
    static let shared = ScreenStatus()

    private init() { }

    var externalScreenConnected: Bool = false
    var idealFontSize: CGFloat = 96
}

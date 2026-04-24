//
//  Notification.Name+gameStateChanged.swift
//  Quiz
//
//  Created by Jakob Handke on 06.03.26.
//

import Foundation

extension Notification.Name {
    static let gameStateChanged = Notification.Name("gameStateChanged")
    static let hideExternalDisplay = Notification.Name("hideExternalDisplay")
    static let showExternalDisplay = Notification.Name("showExternalDisplay")
}

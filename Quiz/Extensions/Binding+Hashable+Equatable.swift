//
//  Binding+Hashable+Equatable.swift
//  Quiz
//
//  Created by Jakob Handke on 24.04.26.
//

// Stolen from https://www.polpiella.dev/binding-navigation

import SwiftUI

extension Binding: @retroactive Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.wrappedValue.hashValue)
    }
}

extension Binding: @retroactive Equatable where Value: Equatable {
    public static func == (lhs: Binding<Value>, rhs: Binding<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}

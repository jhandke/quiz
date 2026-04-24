//
//  Observation+withObservationTracking.swift
//  Quiz
//
//  Created by Jakob Handke on 21.04.26.
//

// Stolen from https://www.polpiella.dev/observable-outside-of-a-view

import Observation
import Foundation

func withObservationTracking<T: Sendable>(of value: @Sendable @escaping @autoclosure () -> T, execute: @Sendable @escaping (T) -> Void) {
    Observation.withObservationTracking {
        execute(value())
    } onChange: {
        RunLoop.current.perform {
            withObservationTracking(of: value(), execute: execute)
        }
    }
}

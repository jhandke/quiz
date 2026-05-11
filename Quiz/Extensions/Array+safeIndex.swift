//
//  Array+safeIndex.swift
//  Quiz
//
//  Created by Jakob Handke on 25.03.26.
//

// Stolen from https://www.hackingwithswift.com/example-code/language/how-to-make-array-access-safer-using-a-custom-subscript

import Foundation

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}

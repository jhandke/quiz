//
//  NavigationState.swift
//  Quiz
//
//  Created by Jakob Handke on 10.05.26.
//

import Combine
import SwiftUI

class NavigationState: ObservableObject {
    @Published var path = NavigationPath()

    init() { }

    func popToHome() {
        path.removeLast(path.count)
    }
}

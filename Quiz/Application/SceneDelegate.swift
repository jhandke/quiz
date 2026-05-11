//
//  SceneDelegate.swift
//  Quiz
//
//  Created by Jakob Handke on 05.03.26.
//

import Foundation
import UIKit
import SwiftUI
import SwiftData

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    var externalWindow: UIWindow?
    weak var externalWindowScene: UIWindowScene?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        if session.role == .windowExternalDisplayNonInteractive {
            debugPrint("External display connected.")
            let window = UIWindow(windowScene: windowScene)
            self.externalWindowScene = windowScene
            debugPrint(window.screen.availableModes)
            debugPrint("Using:", window.screen.currentMode ?? "mode unavailable")

            //            let bestMode = window.screen.availableModes.max {
            //                $0.size.width < $1.size.width
            //            }

            window.screen.overscanCompensation = .none

            let externalContent = ExternalDisplayView()
            window.rootViewController = UIHostingController(rootView: externalContent)
            window.isHidden = false
            self.externalWindow = window
            ScreenStatus.shared.externalScreenConnected = true
        } else {
            debugPrint("other session role: \(session.role.rawValue)")
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        debugPrint("External display disconnected.")
        self.externalWindow = nil
        self.externalWindowScene = nil
        ScreenStatus.shared.externalScreenConnected = false
    }
}

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
    var internalWindow: UIWindow?
    weak var internalWindowScene: UIWindowScene?

    var externalWindow: UIWindow?
    weak var externalWindowScene: UIWindowScene?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

//        self.externalWindowScene = scene as? UIWindowScene
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

//        if session.role == .windowExternalDisplayNonInteractive {
////            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
////                print("No AppDelegate available. Returning...")
////                return
////            }
//            let window = UIWindow(windowScene: windowScene)
//            self.externalWindowScene = windowScene
//            print(window.screen.availableModes)
//            //            let bestMode = window.screen.availableModes.max {
//            //                $0.size.width < $1.size.width
//            //            }
//            let externalContent = ExternalDisplayView()
//                
//            window.rootViewController = UIHostingController(rootView: externalContent)
//            window.isHidden = false
//            self.externalWindow = window
//            ScreenStatus.shared.externalScreenConnected = true
//            ScreenStatus.shared.idealFontSize = window.frame.height / 20
//        } else {
//            print("other session role: \(session.role.rawValue)")
//        }
    }

//    func sceneWillEnterForeground(_ scene: UIScene) {
//        guard scene.session.role == .windowApplication else { return }
//        NotificationCenter.default.post(name: .showExternalDisplay, object: nil)
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//        guard scene.session.role == .windowApplication else { return }
//        NotificationCenter.default.post(name: .hideExternalDisplay, object: nil)
//    }
}

//
//  SceneDelegate.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)

        window?.rootViewController = ActivityType.getNavigationController(session: session, options: connectionOptions)
        self.window?.makeKeyAndVisible()
    }

    func configure(window: UIWindow?, with activity: NSUserActivity) -> Bool {
        let viewController = TopItemsAssembly.assemble()
        if let navigationController = window?.rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: false)
            viewController.restoreUserActivityState(activity)
            return true
        }
        return false
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) {  }

    func sceneWillResignActive(_ scene: UIScene) {
        if let navController = window!.rootViewController as? UINavigationController {
            scene.userActivity = ActivityType.getRestoredUserActivity(with: navController)
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        return scene.userActivity
    }
}

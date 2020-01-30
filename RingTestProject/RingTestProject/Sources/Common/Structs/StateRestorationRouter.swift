//
//  StateRestorationRouter.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 30.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

enum ActivityType: String {
    case topItems = "TopItemsType"
    case photo = "PhotoType"

    static func getRestoredUserActivity(with navigationController: UINavigationController) -> NSUserActivity? {
        if let viewController = navigationController.viewControllers.last as? PhotoViewController {
            return viewController.userActivity
        } else if let viewController = navigationController.viewControllers.last as? TopItemsViewController {
            return viewController.userActivity
        }

        return nil
    }

    static func getNavigationController(session: UISceneSession,
                                        options: UIScene.ConnectionOptions) -> UINavigationController? {
        guard let userActivity = options.userActivities.first ?? session.stateRestorationActivity else {
            let view = TopItemsAssembly.assemble()
            return UINavigationController(rootViewController: view)
        }

        if userActivity.activityType == ActivityType.topItems.rawValue {
            let view = TopItemsAssembly.assemble(userActivity: userActivity)
            return UINavigationController(rootViewController: view)
        } else if userActivity.activityType == ActivityType.photo.rawValue,
            let link = userActivity.userInfo?[PhotoViewController.Default.photoLink.rawValue] as? String {
            let topItemsVC = TopItemsAssembly.assemble()
            let photoVC = PhotoAssembly.assemble(with: link)
            let navController = UINavigationController(rootViewController: topItemsVC)
            navController.pushViewController(photoVC, animated: true)
            return navController
        } else { return nil }
    }
}

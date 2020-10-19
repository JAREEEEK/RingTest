//
//  TopItemsAssembly.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class TopItemsAssembly {
    static func assemble(userActivity: NSUserActivity? = nil) -> UIViewController {
        let view = TopItemsViewController.instantiateViewController()
        let router = TopItemsRouter(view: view)
        let presenter = TopItemsPresenter(interface: view)
        let interactor = TopItemsInteractor(output: presenter)

        view.onRefresh = interactor.loadTopItems(after:)
        view.onSelection = router.showFullImage
        
        if let userActivity = userActivity,
            userActivity.activityType == ActivityType.topItems.rawValue,
            let lastItem = userActivity.userInfo?[TopItemsViewController.Default.lastWatchedItem.rawValue] as? String {
            view.lastSeenItemId = lastItem
        }

        return view
    }
}

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
        let interactor = TopItemsInteractor()
        let router = TopItemsRouter(view: view)
        let presenter = TopItemsPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        if let userActivity = userActivity,
            userActivity.activityType == ActivityType.topItems.rawValue,
            let lastItem = userActivity.userInfo?[TopItemsViewController.Default.lastWatchedItem.rawValue] as? String {
            interactor.lastSeenItem = lastItem
        }

        return view
    }
}

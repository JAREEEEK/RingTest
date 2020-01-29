//
//  PhotoRouter.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import UIKit

final class PhotoRouter: PhotoRouterProtocol {

    private weak var viewController: UIViewController?

    init(view: UIViewController) {
        self.viewController = view
    }

    func dismiss() {
        self.viewController?.dismiss(animated: true, completion: nil)
    }
}

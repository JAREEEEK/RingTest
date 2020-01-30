//
//  TopItemsRouter.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class TopItemsRouter: TopItemsRouterProtocol {

    private weak var viewController: UIViewController?

    init(view: UIViewController) {
        self.viewController = view
    }

    func showFullImage(with link: String) {
        let viewController = PhotoAssembly.assemble(with: link)
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}

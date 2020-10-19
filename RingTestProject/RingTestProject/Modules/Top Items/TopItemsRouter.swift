//
//  TopItemsRouter.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class TopItemsRouter {

    private weak var viewController: UIViewController?

    init(view: UIViewController) {
        self.viewController = view
    }

    func showFullImage(with post: PostViewModel) {
        guard let link = post.imageLink else { return }

        let viewController = PhotoAssembly.assemble(with: link)
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}

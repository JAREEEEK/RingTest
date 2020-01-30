//
//  PhotoRouter.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 30.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

final class PhotoRouter: PhotoRouterProtocol {

    private weak var viewController: UIViewController?

    init(view: UIViewController) {
        self.viewController = view
    }
    
    func dismiss() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}

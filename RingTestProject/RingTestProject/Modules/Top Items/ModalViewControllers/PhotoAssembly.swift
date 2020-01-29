//
//  PhotoAssembly.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class PhotoAssembly {
    static func assemble(with link: String) -> UIViewController {
        let view = PhotoViewController.instantiateViewController()
        let interactor = PhotoInteractor()
        let router = PhotoRouter(view: view)
        let presenter = PhotoPresenter(link: link, interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}

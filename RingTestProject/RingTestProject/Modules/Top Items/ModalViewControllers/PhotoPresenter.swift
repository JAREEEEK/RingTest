//
//  PhotoPresenter.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class PhotoPresenter: PhotoPresenterProtocol, PhotoInteractorOutputProtocol {

    weak private var view: PhotoViewProtocol?
    private let interactor: PhotoInteractorInputProtocol
    private let router: PhotoRouterProtocol

    init(interface: PhotoViewProtocol,
         interactor: PhotoInteractorInputProtocol,
         router: PhotoRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}

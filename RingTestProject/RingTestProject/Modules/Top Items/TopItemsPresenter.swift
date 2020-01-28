//
//  TopItemsPresenter.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class TopItemsPresenter: TopItemsPresenterProtocol, TopItemsInteractorOutputProtocol {

    weak private var view: TopItemsViewProtocol?
    private let interactor: TopItemsInteractorInputProtocol
    private let router: TopItemsRouterProtocol

    init(interface: TopItemsViewProtocol,
         interactor: TopItemsInteractorInputProtocol,
         router: TopItemsRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}

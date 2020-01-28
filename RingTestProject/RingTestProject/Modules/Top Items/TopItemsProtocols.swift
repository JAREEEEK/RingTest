//
//  TopItemsProtocols.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import Foundation

// MARK: Router -
protocol TopItemsRouterProtocol: class {

}

// MARK: Presenter -
protocol TopItemsPresenterProtocol: class {
    func viewIsReady()
    func refreshData()
}

// MARK: Interactor -
protocol TopItemsInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol TopItemsInteractorInputProtocol: class {

    /* Presenter -> Interactor */
}

// MARK: View -
protocol TopItemsViewProtocol: class {
    var props: TopItemsProps { get set }

    func showError(with text: String)

    /* Presenter -> ViewController */
}

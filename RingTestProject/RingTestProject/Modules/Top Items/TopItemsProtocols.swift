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
    func showError(with text: String)
    
    /* Presenter -> ViewController */
}

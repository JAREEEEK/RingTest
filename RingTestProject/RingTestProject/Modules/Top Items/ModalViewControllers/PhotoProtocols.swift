//
//  PhotoProtocols.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import Foundation

// MARK: Router -
protocol PhotoRouterProtocol: class {

}

// MARK: Presenter -
protocol PhotoPresenterProtocol: class {

}

// MARK: Interactor -
protocol PhotoInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol PhotoInteractorInputProtocol: class {

    /* Presenter -> Interactor */
}

// MARK: View -
protocol PhotoViewProtocol: class {
    var props: PhotoProps { get set }
    
    /* Presenter -> ViewController */
}

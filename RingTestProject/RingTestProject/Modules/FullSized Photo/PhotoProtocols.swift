//
//  PhotoProtocols.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import Foundation
import UIKit

// MARK: Router -
protocol PhotoRouterProtocol: class {
    func dismiss()
}

// MARK: Presenter -
protocol PhotoPresenterProtocol: class {
    func viewIsReady()
}

// MARK: Interactor -
protocol PhotoInteractorOutputProtocol: class {
    func didLoad(image: UIImage)
    func didFailLoading(with description: String)
    
    /* Interactor -> Presenter */
}

protocol PhotoInteractorInputProtocol: class {
    func loadImage(with link: String)
    func cancel()
    
    /* Presenter -> Interactor */
}

// MARK: View -
protocol PhotoViewProtocol: class {
    var props: PhotoProps { get set }

    func showError(with text: String)

    /* Presenter -> ViewController */
}

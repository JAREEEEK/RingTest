//
//  PhotoPresenter.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class PhotoPresenter: PhotoPresenterProtocol, PhotoInteractorOutputProtocol {
    typealias Props = PhotoProps
    typealias State = Props.State

    // MARK: - Dependencies
    weak private var view: PhotoViewProtocol?
    private let interactor: PhotoInteractorInputProtocol
    private let router: PhotoRouterProtocol
    private let link: String

    // MARK: - Initialization
    init(link: String,
         interface: PhotoViewProtocol,
         interactor: PhotoInteractorInputProtocol,
         router: PhotoRouterProtocol) {
        self.link = link
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    // MARK: - PhotoPresenterProtocol
    func viewIsReady() {
        self.view?.props = makeProps(with: link)
    }

    // MARK: - PhotoInteractorOutputProtocol
    func didLoad(image: UIImage) {
        print()
    }

    func didFailLoading(with description: String) {
        self.view?.showError(with: description)
    }

    // MARK: - Props generation
    private func makeProps(with link: String) -> Props {
        Props(state: .photo(link),
              didPushSaveButton: CommandWith { [weak self] in self?.didPushSaveButton() })
    }

    // MARK: - Private functions
    private func didPushSaveButton() {
        self.changeViewState(with: .loading)
        self.interactor.loadImage(with: link)
    }

    private func changeViewState(with newState: State) {
        guard let view = view else { return }
        view.props = Props.stateLens.set(newState, view.props)
    }
}

//
//  TopItemsPresenter.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class TopItemsPresenter: TopItemsPresenterProtocol, TopItemsInteractorOutputProtocol {
    typealias Props = TopItemsProps
    typealias State = Props.State

    // MARK: - Dependencies
    weak private var view: TopItemsViewProtocol?
    private let interactor: TopItemsInteractorInputProtocol
    private let router: TopItemsRouterProtocol

    // MARK: - Initialization
    init(interface: TopItemsViewProtocol,
         interactor: TopItemsInteractorInputProtocol,
         router: TopItemsRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    // MARK: - TopItemsPresenterProtocol
    func viewIsReady() {
        self.changeViewState(with: .loading)
        self.interactor.loadTopItems()
    }

    func refreshData() {
        self.interactor.loadTopItems()
    }

    // MARK: - TopItemsInteractorOutputProtocol
    func didLoad(posts: [Child]) {
        self.view?.props = makeProps(with: posts)
    }

    func didFailLoading(with error: Error) {
        self.view?.showError(with: error.localizedDescription)
    }

    // MARK: - Props generation
    private func makeProps(with children: [Child]) -> Props {
        var views: [TableElement] = []

        children.forEach { child in
            let post = child.data
            let model = PostViewModel(post: post)
            let element = TableElement(model: model as AnyObject,
                                       onSelect: .empty)
            views.append(element)
        }

        return Props(state: .posts(views))
    }

    // MARK: - Private functions
    private func changeViewState(with newState: State) {
        guard let view = view else { return }
        view.props = Props.stateLens.set(newState,
                                         view.props)
    }
}

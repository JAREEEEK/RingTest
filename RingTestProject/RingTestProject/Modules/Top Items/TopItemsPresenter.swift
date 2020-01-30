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
        self.interactor.clear()
        self.interactor.loadTopItems()
    }

    // MARK: - TopItemsInteractorOutputProtocol
    func didLoad(posts: [Child]) {
        self.view?.props = makeProps(with: posts)
    }

    func didLoadMore(posts: [Child]) {
        self.view?.props = makeProps(with: posts, isInitial: false)
    }

    func didFailLoading(with error: Error) {
        self.view?.showError(with: error.localizedDescription)
    }

    // MARK: - Props generation
    private func makeProps(with children: [Child], isInitial: Bool = true) -> Props {
        var views: [TableElement] = isInitial ? [] : self.view?.props.state.posts ?? []

        children.forEach { child in
            let post = child.data
            let model = PostViewModel(post: post)
            let element = TableElement(
                elementId: "t3_\(post.postId)",
                model: model as AnyObject,
                onSelect: CommandWith { [weak self] in self?.didSelect(post: post) }
            )
            views.append(element)
        }

        return Props(state: .posts(views), onNextPage: CommandWith { [weak self] in self?.onNextPage() })
    }

    // MARK: - Private functions
    private func changeViewState(with newState: State) {
        guard let view = view else { return }
        view.props = Props.stateLens.set(newState, view.props)
    }

    private func onNextPage() {
        self.interactor.loadMoreItems()
    }

    private func didSelect(post: Post) {
        guard let link = post.preview?.images.first?.source?.url else { return }
        self.router.showFullImage(with: link)
    }
}

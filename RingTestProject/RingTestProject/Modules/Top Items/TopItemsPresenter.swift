//
//  TopItemsPresenter.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

protocol TopItemsViewProtocol: class {
    var props: TopItemsProps { get set }

    func showError(with text: String)
}

final class TopItemsPresenter: TopItemsInteractorOutputProtocol {
    typealias Props = TopItemsProps
    typealias State = Props.State

    // MARK: - Dependencies
    weak private var view: TopItemsViewProtocol?

    // MARK: - Initialization
    init(interface: TopItemsViewProtocol) {
        self.view = interface
    }

    // MARK: - TopItemsInteractorOutputProtocol
    func didStartLoading(cancel: @escaping () -> Void) {
        changeViewState(with: .loading(cancel: CommandWith(action: cancel)))
    }
    
    func didLoad(posts: [Child], after: String?, next: @escaping () -> Void) {
        self.view?.props = makeProps(with: posts, isInitial: after == nil, next: next)
    }

    func didFailLoading(with error: Error) {
        self.view?.showError(with: error.localizedDescription)
    }

    // MARK: - Props generation
    private func makeProps(with children: [Child], isInitial: Bool = true, next: @escaping () -> Void) -> Props {
        var posts: [TableElement] = isInitial ? [] : self.view?.props.posts ?? []

        children.forEach { child in
            let post = child.data
            let model = PostViewModel(post: post)
            let element = TableElement(
                elementId: "t3_\(post.postId)",
                model: model,
                onSelect: .empty
            )
            posts.append(element)
        }

        return Props(state: .partial(onNextPage: CommandWith { next() }), posts: posts)
    }

    // MARK: - Private functions
    private func changeViewState(with newState: State) {
        guard let view = view else { return }
        view.props = Props.stateLens.set(newState, view.props)
    }
}

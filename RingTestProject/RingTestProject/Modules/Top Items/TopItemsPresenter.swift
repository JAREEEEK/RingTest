//
//  TopItemsPresenter.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class TopItemsPresenter: TopItemsPresenterProtocol, TopItemsInteractorOutputProtocol {
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
    private func makeProps(with children: [Child]) -> TopItemsProps {
        var views: [TableElement] = []

        children.forEach { child in
            let post = child.data
            let date = Date(timeIntervalSince1970: post.created ?? 0) ?? Date()
            let model = PostViewModel(title: post.title,
                                      author: post.author,
                                      createdAt: "Created",
                                      comments: String(post.numberOfComments ?? 0))
            let element = TableElement(identifier: PostTableViewCell.identifier,
                                       model: model as AnyObject,
                                       onSelect: .empty)
            views.append(element)
        }


        return TopItemsProps(state: .posts(views))
    }
}

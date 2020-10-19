//
//  TopItemsInteractor.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit
import Combine

final class TopItemsInteractor: TopItemsInteractorInputProtocol {
    weak var presenter: TopItemsInteractorOutputProtocol?
    var lastSeenItem: String?
    private var request: AnyCancellable?
    private var before: String?
    private var after: String?

    func loadTopItems() {
        request = RedditAPI.topItems(limit: 20, after: lastSeenItem)
            .sink(receiveCompletion: { errorData in
                switch errorData {
                case .failure(let error):
                    self.presenter?.didFailLoading(with: error)
                default: break
                }
            }, receiveValue: { items in
                self.before = items.data.before
                self.after = items.data.after
                self.presenter?.didLoad(posts: items.data.children)
            })
    }

    func loadMoreItems() {
        // check if we can load more items
        if after == nil { return }

        // load more items
        request = RedditAPI.topItems(limit: 20, before: before, after: after)
            .sink(receiveCompletion: { errorData in
                switch errorData {
                case .failure(let error):
                    self.presenter?.didFailLoading(with: error)
                default: break
                }
            }, receiveValue: { items in
                self.before = items.data.before
                self.after = items.data.after
                self.presenter?.didLoadMore(posts: items.data.children)
            })
    }

    func clear() {
        self.before = nil
        self.after = nil
        self.lastSeenItem = nil
    }
}

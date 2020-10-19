//
//  TopItemsInteractor.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit
import Combine

protocol TopItemsInteractorOutputProtocol: class {
    func didStartLoading(cancel: @escaping () -> Void)
    func didLoad(posts: [Child], after: String?, next: @escaping () -> Void)
    func didFailLoading(with error: Error)
}

final class TopItemsInteractor {
    private let output: TopItemsInteractorOutputProtocol

    init(output: TopItemsInteractorOutputProtocol) {
        self.output = output
    }
    
    func loadTopItems(after: String?) {
        output.didStartLoading(
            cancel: RedditAPI.topItems(limit: 20, after: after)
                .sink(receiveCompletion: { errorData in
                    switch errorData {
                    case .failure(let error):
                        self.output.didFailLoading(with: error)
                    default: break
                    }
                }, receiveValue: { items in
                    self.output.didLoad(posts: items.data.children, after: after, next: { [weak self] in
                        self?.loadTopItems(after: items.data.after)
                    })
                }).cancel)
    }
}

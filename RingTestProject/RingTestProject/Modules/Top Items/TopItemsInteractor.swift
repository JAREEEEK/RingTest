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
    private var request: AnyCancellable?

    func loadTopItems() {
        request = RedditAPI.topItems()
            .sink(receiveCompletion: { errorData in
                switch errorData {
                case .failure(let error):
                    self.presenter?.didFailLoading(with: error)
                default: break
                }
            }, receiveValue: { items in
                self.presenter?.didLoad(posts: items.data.children)
            })
    }

    func cancelRequest() {
        request?.cancel()
    }
}

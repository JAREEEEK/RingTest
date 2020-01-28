//
//  RedditAPI.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import Combine

enum RedditAPI {
    static let network = NetworkLayer()
    static let base = URL(string: "https://www.reddit.com/")!
}

extension RedditAPI {
    static func topItems(_ limit: Int = 20, _ before: String? = nil, _ after: String? = nil) -> AnyPublisher<TopItems, Error> {
        var url = base.appendingPathComponent("top.json")

        if let before = before {
            url = url.appendingPathComponent("&before=\(before)")
        }

        if let after = after {
            url = url.appendingPathComponent("&after=\(after)")
        }

        return add(URLRequest(url: url))
    }

    static func add<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        self.network.add(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

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
    static func topItems(limit: Int = 20, before: String? = nil, after: String? = nil) -> AnyPublisher<TopItems, Error> {
        let url = base.appendingPathComponent("top.json")

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let limit = URLQueryItem(name: "limit", value: String(limit))
        components?.queryItems = [limit]

        // It is necessary to obtain correct images urls
        let rawJson = URLQueryItem(name: "raw_json", value: String(1))
        components?.queryItems?.append(rawJson)

        if let before = before {
            let beforeItem = URLQueryItem(name: "before", value: before)
            components?.queryItems?.append(beforeItem)
        }

        if let after = after {
            let afterItem = URLQueryItem(name: "after", value: after)
            components?.queryItems?.append(afterItem)
        }

        let request = URLRequest(url: (components?.url)!)

        return add(request)
    }

    static func add<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        self.network.add(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

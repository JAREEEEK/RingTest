//
//  TopItemsProps.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation

struct TopItemsProps {
    let state: State

    enum State {
        case loading
        case posts([TableElement])
    }

    static let initial = TopItemsProps(state: .loading)
}

extension TopItemsProps {
    static let stateLens = Lens<TopItemsProps, State>(
        get: { $0.state },
        set: { value, props in
            TopItemsProps(state: value)
    }
    )
}

extension TopItemsProps.State {
    var isLoading: Bool {
        get {
            guard case .loading = self else { return false }
            return true
        }
        set {
            guard newValue else { fatalError("Setting false value forbidden") }
            self = .loading
        }
    }

    var posts: [TableElement]? {
        get {
            guard case let .posts(posts) = self else { return nil }
            return posts
        }
        set {
            guard let newValue = newValue else { fatalError("Setting nil value forbidden") }
            /*Set self from the case has associated value or not*/
            self = .posts(newValue)
        }
    }
}

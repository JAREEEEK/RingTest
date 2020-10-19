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
    let posts: [TableElement]

    enum State {
        case idle
        case loading
        case partial(onNextPage: Command)
    }

    static let initial = TopItemsProps(state: .idle, posts: [])
}

extension TopItemsProps {
    static let stateLens = Lens<TopItemsProps, State>(
        get: { $0.state },
        set: { value, props in
            TopItemsProps(state: value, posts: props.posts)
        }
    )
    
    var onNextPage: Command? {
        guard case let .partial(onNextPage) = state else { return nil }
        return onNextPage
    }
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
}

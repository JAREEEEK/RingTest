//
//  PhotoProps.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

struct PhotoProps {
    let state: State
    let didPushSaveButton: Command

    enum State {
        case loading, photo(String)
    }

    static let initial = PhotoProps(state: .loading, didPushSaveButton: .empty)
}

extension PhotoProps {
    static let stateLens = Lens<PhotoProps, State>(
        get: { $0.state },
        set: { value, props in
            PhotoProps(state: value, didPushSaveButton: props.didPushSaveButton)
    }
    )
    static let didPushSaveButtonLens = Lens<PhotoProps, Command>(
        get: { $0.didPushSaveButton },
        set: { value, props in
            PhotoProps(state: props.state, didPushSaveButton: value)
    }
    )
}

extension PhotoProps.State {
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

    var photo: String? {
        get {
            guard case let .photo(photo) = self else { return nil }
            return photo
        }
        set {
            guard let newValue = newValue else { fatalError("Setting nil value forbidden") }
            self = .photo(newValue)
        }
    }
}

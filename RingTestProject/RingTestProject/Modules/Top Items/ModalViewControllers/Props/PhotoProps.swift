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

    enum State {
        case loading, photo(UIImage)
    }

    static let initial = PhotoProps(state: .loading)
}

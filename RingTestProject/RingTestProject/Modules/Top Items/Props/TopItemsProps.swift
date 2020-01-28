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
        case empty
        case loading
        case posts([TableElement])
    }

    static let initial = TopItemsProps(state: .empty)
}

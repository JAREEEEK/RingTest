//
//  Error.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation

public enum CustomError: Error {
    case noImage
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noImage:
            return "Error image downloading. Try again later"
        }
    }
}

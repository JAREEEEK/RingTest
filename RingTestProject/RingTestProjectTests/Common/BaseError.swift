//
//  BaseError.swift
//  RingTestProjectTests
//
//  Created by Yaroslav Nosik on 30.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation

struct BaseError: Codable, LocalizedError {
    let code: BaseErrorCode
    let message: String

    init(code: Int, message: String) {
        self.code = BaseErrorCode(rawValue: code) ?? .unknownError
        self.message = message
    }

    private enum CodingKeys: String, CodingKey {
        case message, code
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.code.rawValue, forKey: .code)
        try container.encode(self.message, forKey: .code)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let code = try container.decode(Int.self, forKey: .code)
        let message = try container.decode(String.self, forKey: .message)
        self.init(code: code, message: message)
    }
}

enum BaseErrorCode: Int {
    case unknownError = 0
}

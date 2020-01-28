//
//  Command.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation

import Foundation

typealias Command = CommandWith<Void>

struct CommandWith<T> {
    private var action: (T) -> Void

    static var empty: CommandWith { return CommandWith { _ in } }

    public init(action: @escaping (T) -> Void) {
        self.action = action
    }
    public func perform(with value: T) {
        self.action(value)
    }
}

extension CommandWith where T == Void {
    func perform() {
        self.perform(with: ())
    }
}

extension CommandWith {
    func bind(to value: T) -> Command {
        return Command { self.perform(with: value) }
    }

    func map<U>(block: @escaping (U) -> T) -> CommandWith<U> {
        return CommandWith<U> { self.perform(with: block($0)) }
    }
}

extension CommandWith: Codable {

    private static var currentType: String {
        return T.self == Void.self
            ? "Command"
            : String(describing: CommandWith.self)
    }

    enum CodingError: Error { case decoding(String) }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let descriptor = try container.decode(String.self)
        guard CommandWith.currentType == descriptor else {
            throw CodingError.decoding("Decoding Failed. Exptected: \(CommandWith.currentType). Recieved \(descriptor)")
        }
        self = .empty
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(CommandWith.currentType)
    }
}

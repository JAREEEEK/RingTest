//
//  LocalizationTopItems.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation

final class LocalizationTopItems {
    private let table = "LocalizationTopItems"

    public init() { }

    func localized(string: String) -> String {
        return Localization.localizedString(key: string, table: table)
    }
}

extension LocalizationTopItems {
    // MARK: - Alert titles

    func alertTitleError() -> String {
        return Localization.localizedString(key: "Error", table: self.table)
    }

    // MARK: - Alert messages
    func alertMessageOk() -> String {
        return Localization.localizedString(key: "alert.message.ok", table: self.table)
    }
}

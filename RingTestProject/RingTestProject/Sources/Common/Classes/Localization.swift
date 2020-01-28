//
//  Localization.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

public final class Localization: NSObject {

    // MARK: - Public localization funcs
    public static func localizedString(key: String) -> String {
        return Localization.shared.localizedString(key, value: nil, tableName: nil)
    }

    public static func localizedString(key: String, table: String) -> String {
        return Localization.shared.localizedString(key, value: nil, tableName: table)
    }

    public static func localizedString(key: String, value: String, table: String) -> String {
        return Localization.shared.localizedString(key, value: value, tableName: table)
    }

    public static func localizedImage(name: NSString) -> UIImage? {
        return Localization.shared.localizedImage(name: name)
    }

    public static func localizedBundle(nibName: String) -> Bundle? {
        return Localization.shared.localizedBundle(nibName: nibName)
    }

    // MARK: - Initializers
    public static let shared = Localization()

    public lazy var bundles = [Bundle.main]

    // MARK: - Localization resources
    public func localizedString(_ key: String, value: String?, tableName: String?) -> String {
        var string = key

        for bundle in self.bundles {
            let localizedString = bundle.localizedString(forKey: key, value: value, table: tableName)

            if localizedString != key &&
                localizedString != value {
                string = localizedString
                break
            }
        }

        return string
    }

    public func localizedBundle(nibName: String) -> Bundle? {
        guard nibName.isEmpty == false else { return nil }

        var localizedBundle: Bundle?

        for bundle in self.bundles {
            if bundle.path(forResource: nibName, ofType: "nib") != nil {
                localizedBundle = bundle
                break
            }
        }

        return localizedBundle
    }

    public func localizedImage(name: NSString) -> UIImage? {
        let fileName = name.deletingPathExtension

        guard fileName.isEmpty == false else { return nil }

        var pathExtension = name.pathExtension

        if pathExtension.isEmpty {
            pathExtension = "png"
        }

        var image: UIImage?
        for bundle in self.bundles {
            if let path = bundle.path(forResource: fileName, ofType: pathExtension) {
                image = UIImage(contentsOfFile: path)
                break
            }
        }

        return image
    }
}

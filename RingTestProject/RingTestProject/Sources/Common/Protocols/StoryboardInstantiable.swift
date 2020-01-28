//
//  StoryboardInstantiable.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype ControllerType
    static var storyboardName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> ControllerType
}

extension StoryboardInstantiable where Self: UIViewController {

    static var storyboardName: String {
        return String(describing: self)
    }

    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = storyboardName
        assert((bundle ?? Bundle.main).path(forResource: fileName, ofType: "storyboardc") != nil,
               "Can't load storyboard of given name")
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        return storyboard.instantiateInitialViewController() as! Self // swiftlint:disable:this force_cast
    }

    static func instantiateViewController(identifier: String, bundle: Bundle? = nil) -> Self {
        let fileName = storyboardName
        assert((bundle ?? Bundle.main).path(forResource: fileName, ofType: "storyboardc") != nil,
               "Can't load storyboard of given name")
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}

//
//  UINib+Extensions.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

extension UINib {
    static func nib(withClass cls: AnyClass) -> UINib {
        return self.nib(withClass: cls, bundle: nil)
    }

    static func nib(withClass cls: AnyClass, bundle: Bundle?) -> UINib {
        return UINib(nibName: String(describing: cls), bundle: bundle)
    }
}

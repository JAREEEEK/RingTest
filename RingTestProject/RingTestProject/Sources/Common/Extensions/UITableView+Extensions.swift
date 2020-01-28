//
//  UITableView+Extensions.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register(cellClass: AnyClass) {
        self.register(UINib.nib(withClass: cellClass),
                      forCellReuseIdentifier: String(describing: cellClass.self))
    }
}


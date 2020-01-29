//
//  ViewModel.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

protocol TableCell: UITableViewCell {
    func setup(with element: TableElement)
}

struct TableElement {
    let model: AnyObject
    let onSelect: Command?
}

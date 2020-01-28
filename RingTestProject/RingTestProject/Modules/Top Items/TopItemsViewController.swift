//
//  TopItemsViewController.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class TopItemsViewController: UIViewController, TopItemsViewProtocol {

	var presenter: TopItemsPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showError(with text: String) { }

}

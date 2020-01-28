//
//  TopItemsViewController.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class TopItemsViewController: BaseViewController, TopItemsViewProtocol {
    // MARK: - Props
    var props: TopItemsProps = .initial {
        didSet {
            self.view.setNeedsLayout()
        }
    }

    // MARK: - Dependencies
	var presenter: TopItemsPresenterProtocol?

    // MARK: View Controller lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }

    // MARK: TopItemsViewProtocol
    func showError(with text: String) {

    }
}

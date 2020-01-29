//
//  BaseViewController.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    private let activityIndicatorBackgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        return backgroundView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorBackgroundView.addSubview(self.activityIndicator)
        self.view.addSubview(self.activityIndicatorBackgroundView)
        self.activityIndicatorBackgroundView.isHidden = true
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.activityIndicatorBackgroundView.frame = self.view.bounds
    }

    func showActivityView() {
        self.view.bringSubviewToFront(activityIndicatorBackgroundView)
        self.activityIndicator.center = self.activityIndicatorBackgroundView.center
        self.activityIndicatorBackgroundView.isHidden = false
        self.activityIndicator.startAnimating()
    }

    func hideActivityView() {
        self.view.sendSubviewToBack(activityIndicatorBackgroundView)
        self.activityIndicatorBackgroundView.isHidden = true
        self.activityIndicator.stopAnimating()
    }

    func showAlert(text: String, alertTitle: String, actionText: String) {
        let alert = UIAlertController(title: alertTitle, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionText, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

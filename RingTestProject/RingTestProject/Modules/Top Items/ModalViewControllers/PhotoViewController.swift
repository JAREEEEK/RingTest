//
//  PhotoViewController.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit
import WebKit

final class PhotoViewController: BaseViewController, PhotoViewProtocol, StoryboardInstantiable {
    // MARK: - Props
    var props: PhotoProps = .initial {
        didSet {
            self.view.setNeedsLayout()
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!

    // MARK: - Dependencies
	var presenter: PhotoPresenterProtocol?
    private let localization = LocalizationTopItems()

    // MARK: - View controller lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.presenter?.viewIsReady()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.setupState()
    }

    // MARK: - PhotoViewProtocol
    func showError(with text: String) {
        self.showAlert(text: text,
                       alertTitle: self.localization.alertTitleError(),
                       actionText: self.localization.alertMessageOk())
    }

    // MARK: - Private functions
    private func setupState() {
        switch props.state {
        case .loading:
            self.showActivityView()
        case .photo(let string):
            guard let url = URL(string: string) else { return }
            let request = URLRequest(url: url)
            webView.load(request)
            self.hideActivityView()
        }
    }

    private func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.save,
            target: self,
            action: #selector(didPushSaveButton(_:))
        )
    }

    // MARK: - Actions
    @objc func didPushSaveButton(_ sender: UIButton) {
        self.props.didPushSaveButton.perform()
    }
}

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
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let localization = LocalizationTopItems()

    // MARK: View Controller lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .white
        self.tableView.insetsContentViewsToSafeArea = true
//        self.tableView.register(TransanctionCell.self, forCellReuseIdentifier: TransanctionCell.identifier)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        self.presenter?.viewIsReady()
    }

    // MARK: TopItemsViewProtocol
    func showError(with text: String) {
        self.showAlert(text: text,
                       alertTitle: self.localization.alertTitleError(),
                       actionText: self.localization.alertMessageOk())
    }

    func showFooterActivityView() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat.zero, y: CGFloat.zero, width: tableView.bounds.width, height: CGFloat(44.0))

        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
    }

    func hideFooterActivityView() {
        self.tableView.tableFooterView = nil
        self.tableView.tableFooterView?.isHidden = true
    }

    // MARK: - Actions
    @objc private func onRefreshing() {
        if !self.tableView.isDragging {
            self.presenter?.refreshData()
        }
    }

    // MARK: - Private functions
    private func addRefreshControl() {
        self.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(onRefreshing), for: .valueChanged)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TopItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if refreshControl.isRefreshing {
            self.presenter?.refreshData()
        }
    }
}

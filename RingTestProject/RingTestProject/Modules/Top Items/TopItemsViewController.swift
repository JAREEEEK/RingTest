//
//  TopItemsViewController.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class TopItemsViewController: BaseViewController, TopItemsViewProtocol, StoryboardInstantiable {
    // MARK: - Props
    var props: TopItemsProps = .initial {
        didSet {
            self.view.setNeedsLayout()
        }
    }

    // MARK: - Dependencies
    @IBOutlet weak var tableView: UITableView!
	var presenter: TopItemsPresenterProtocol?
    private let refreshControl = UIRefreshControl()
    private let localization = LocalizationTopItems()

    // MARK: View Controller lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.tableView.register(cellClass: PostTableViewCell.self)
        self.addRefreshControl()
        self.presenter?.viewIsReady()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setupState()
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

    private func setupState() {
        switch props.state {
        case .loading:
            self.showActivityView()
        case .posts(_):
            self.tableView.reloadData()
            self.hideActivityView()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TopItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.state.posts?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let element = props.state.posts?[safe: indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: element.identifier,
                                                     for: indexPath) as? TableCell {
            cell.setup(with: element)

            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if refreshControl.isRefreshing {
            self.presenter?.refreshData()
        }
    }
}

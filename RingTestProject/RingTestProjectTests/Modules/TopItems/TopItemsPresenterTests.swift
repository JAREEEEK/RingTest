//
//  TopItemsUnitTests.swift
//  RingTestProjectTests
//
//  Created by Yaroslav Nosik on 30.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import XCTest
@testable import RingTestProject

final class TopItemsPresenterTests: XCTestCase {
    var sut: TopItemsPresenter?
    fileprivate var mockView: MockTopItemsView?
    fileprivate var mockRouter: MockTopItemsRouter?
    fileprivate var mockInteractor: MockTopItemsInteractor?

    override func setUp() {
        self.mockView = MockTopItemsView()
        self.mockInteractor = MockTopItemsInteractor()
        self.mockRouter = MockTopItemsRouter()
        guard let mockView = mockView,
            let mockInteractor = mockInteractor,
            let mockRouter = mockRouter else { return }
        self.sut = TopItemsPresenter(interface: mockView,
                                           interactor: mockInteractor,
                                           router: mockRouter)
        self.mockInteractor?.presenter = self.sut

        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        self.sut = nil
        self.mockView = nil
        self.mockInteractor = nil
        self.mockRouter = nil
    }

    // MARK: - View
    func testLoadingStateWhenViewIsReady() {
        guard let mockView = mockView else { return }
        self.mockInteractor?.noReturn = true
        self.sut?.viewIsReady()
        XCTAssertTrue(mockView.props.state.isLoading)
    }

    func testLoadingStateWhenRefreshData() {
        guard let mockView = mockView else { return }
        self.mockInteractor?.noReturn = true
        self.sut?.refreshData()
        XCTAssertTrue(mockView.props.state.isLoading)
    }

    func testUpdatesViewWhenSuccessIsReturned() {
        guard let mockView = mockView else { return }
        self.sut?.viewIsReady()
        XCTAssertFalse(mockView.props.state.isLoading)
    }

    func testWhenFailureItShowsError() {
        guard let mockView = mockView else { return }
        self.mockInteractor?.fail = true
        self.sut?.viewIsReady()
        XCTAssertTrue(mockView.didShowError)
    }

    // MARK: - Interactor
    func testInteractorStartsLoadPost() {
        guard let interactor = mockInteractor else { return }
        self.sut?.viewIsReady()
        XCTAssertTrue(interactor.processing)
    }

    func testInteractorStartsLoadNextPage() {
        guard let interactor = mockInteractor else { return }
        self.sut?.viewIsReady()
        self.mockView?.props.onNextPage.perform()
        XCTAssertTrue(interactor.processing)
    }

    func testInteractorClear() {
        guard let interactor = mockInteractor else { return }
        self.sut?.refreshData()
        XCTAssertTrue(interactor.didClearData)
    }

    // MARK: - Router
    func testShowFullImage() {
        guard let router = mockRouter else { return }
        self.sut?.viewIsReady()
        self.mockView?.props.state.posts?[safe: 0]?.onSelect?.perform()
        XCTAssertTrue(router.didShowFullImage)
    }
}

fileprivate final class MockTopItemsView: TopItemsViewProtocol {
    var props: TopItemsProps = .initial
    var didShowError = false

    func showError(with text: String) {
        didShowError = true
    }
}

fileprivate final class MockTopItemsInteractor: TopItemsInteractorInputProtocol {
    var processing = false
    var fail = false
    var noReturn = false
    var presenter: TopItemsInteractorOutputProtocol?
    var didClearData = false
    var didCancelRequest = false

    func loadTopItems() {
        self.processing = true
        guard !noReturn else { return }
        if fail {
            self.presenter?.didFailLoading(with: BaseError.init(code: -1, message: "Empty error"))
        } else {
            guard let children = self.filledData() else { return }
            self.presenter?.didLoad(posts: children)
        }
    }

    func loadMoreItems() {
        self.processing = true
        guard !noReturn else { return }
        if fail {
            self.presenter?.didFailLoading(with: BaseError.init(code: -1, message: "Empty error"))
        } else {
            guard let children = self.filledData() else { return }
            self.presenter?.didLoadMore(posts: children)
        }
    }

    func clear() {
        didClearData = true
    }

    func cancelRequest() {
        didCancelRequest = true
    }

    private func filledData() -> [Child]? {
        guard let url = Bundle.main.url(forResource: "TopItemsTestData",
                                        withExtension: "json"),
            let jsonData = try? Data(contentsOf: url) else { return nil }

        let topItems = try? JSONDecoder().decode(TopItems.self, from: jsonData)

        return topItems?.data.children
    }
}

fileprivate final class MockTopItemsRouter: TopItemsRouterProtocol {
    var didShowFullImage = false

    func showFullImage(with link: String) {
        didShowFullImage = true
    }
}

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
    private var sut: TopItemsPresenter!
    private var mockView: MockTopItemsView!
    private var mockRouter: MockTopItemsRouter!
    private var mockInteractor: MockTopItemsInteractor!

    override func setUp() {
        mockView = MockTopItemsView()
        mockInteractor = MockTopItemsInteractor()
        mockRouter = MockTopItemsRouter()
        
        sut = TopItemsPresenter(
            interface: mockView,
            interactor: mockInteractor,
            router: mockRouter)
        
        mockInteractor.presenter = sut

        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
    }

    // MARK: - View
    func testLoadingStateWhenViewIsReady() {
        mockInteractor.noReturn = true
        
        XCTAssertFalse(mockView.props.state.isLoading, "precondition")

        sut.viewIsReady()
        
        XCTAssertTrue(mockView.props.state.isLoading)
    }

    func testLoadingStateWhenRefreshData() {
        mockInteractor.noReturn = true

        XCTAssertFalse(mockView.props.state.isLoading, "precondition")

        sut.refreshData()

        XCTAssertTrue(mockView.props.state.isLoading)
    }

    func testUpdatesViewWhenSuccessIsReturned() {
        sut.viewIsReady()

        XCTAssertFalse(mockView.props.state.isLoading)
    }

    func testWhenFailureItShowsError() {
        mockInteractor.fail = true

        sut.viewIsReady()

        XCTAssertTrue(mockView.didShowError)
    }

    // MARK: - Interactor
    func testInteractorStartsLoadPost() {
        sut.viewIsReady()

        XCTAssertTrue(mockInteractor.processing)
    }

    func testInteractorStartsLoadNextPage() {
        sut.viewIsReady()
        
        mockView.props.onNextPage.perform()
        
        XCTAssertTrue(mockInteractor.processing)
    }

    func testInteractorClear() {
        sut.refreshData()
        
        XCTAssertTrue(mockInteractor.didClearData)
    }

    // MARK: - Router
    func testShowFullImage() {
        sut.viewIsReady()
        
        mockView.props.state.posts?[safe: 0]?.onSelect?.perform()
        
        XCTAssertTrue(mockRouter.didShowFullImage)
    }
}

private final class MockTopItemsView: TopItemsViewProtocol {
    var props: TopItemsProps = .initial
    var didShowError = false

    func showError(with text: String) {
        didShowError = true
    }
}

private final class MockTopItemsInteractor: TopItemsInteractorInputProtocol {
    var processing = false
    var fail = false
    var noReturn = false
    var presenter: TopItemsInteractorOutputProtocol?
    var didClearData = false
    var didCancelRequest = false

    func loadTopItems() {
        processing = true
        guard !noReturn else { return }
        if fail {
            presenter?.didFailLoading(with: BaseError.init(code: -1, message: "Empty error"))
        } else {
            guard let children = filledData() else { return }
            presenter?.didLoad(posts: children)
        }
    }

    func loadMoreItems() {
        processing = true
        guard !noReturn else { return }
        if fail {
            presenter?.didFailLoading(with: BaseError.init(code: -1, message: "Empty error"))
        } else {
            guard let children = filledData() else { return }
            presenter?.didLoadMore(posts: children)
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

private final class MockTopItemsRouter: TopItemsRouterProtocol {
    var didShowFullImage = false

    func showFullImage(with link: String) {
        didShowFullImage = true
    }
}

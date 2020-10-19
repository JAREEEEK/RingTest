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
        XCTAssertFalse(mockView.props.state.isLoading, "precondition")

        sut.viewIsReady()
        
        XCTAssertTrue(mockView.props.state.isLoading)
    }

    func testLoadingStateWhenRefreshData() {
        XCTAssertFalse(mockView.props.state.isLoading, "precondition")

        sut.refreshData()

        XCTAssertTrue(mockView.props.state.isLoading)
    }

    func testUpdatesViewWhenTopItemsReturned() throws {
        sut.viewIsReady()

        XCTAssertTrue(mockView.props.state.isLoading, "precondition")
        
        sut.didLoad(posts: try filledData())

        XCTAssertFalse(mockView.props.state.isLoading)
    }
    
    func testReplacesPostsWhenTopItemsReturned() throws {
        let posts = try filledData()
        
        XCTAssertNil(mockView.props.state.posts, "precondition")
        
        sut.didLoad(posts: posts)

        XCTAssertEqual(mockView.props.state.posts?.count, posts.count)
        
        sut.didLoad(posts: posts)

        XCTAssertEqual(mockView.props.state.posts?.count, posts.count)
    }
    
    func testAppendsPostsWhenMoreItemsReturned() throws {
        let posts = try filledData()
        
        XCTAssertNil(mockView.props.state.posts, "precondition")
        
        sut.didLoad(posts: posts)

        XCTAssertEqual(mockView.props.state.posts?.count, posts.count)
        
        sut.didLoadMore(posts: posts)

        XCTAssertEqual(mockView.props.state.posts?.count, posts.count * 2)
    }
    
    func testUpdatesViewWhenMoreItemsReturned() throws {
        sut.viewIsReady()

        XCTAssertTrue(mockView.props.state.isLoading, "precondition")
        
        sut.didLoadMore(posts: try filledData())

        XCTAssertFalse(mockView.props.state.isLoading)
    }

    func testWhenFailureItShowsError() {
        XCTAssertEqual(mockView.shownErrors, [], "precondition")

        sut.didFailLoading(with: BaseError(code: -1, message: "Empty error"))

        XCTAssertEqual(mockView.shownErrors, ["Empty error"])
    }

    // MARK: - Interactor
    func testInteractorStartsLoadPost() {
        XCTAssertEqual(mockInteractor.messages, [], "precondition")

        sut.viewIsReady()

        XCTAssertEqual(mockInteractor.messages, [.loadTopItems])
    }

    func testInteractorStartsLoadNextPage() throws {
        sut.didLoad(posts: try filledData())
        
        XCTAssertEqual(mockInteractor.messages, [], "precondition")

        mockView.props.onNextPage.perform()
        
        XCTAssertEqual(mockInteractor.messages, [.loadMoreItems])
    }

    func testInteractorClear() {
        XCTAssertEqual(mockInteractor.messages, [], "precondition")

        sut.refreshData()
        
        XCTAssertEqual(mockInteractor.messages, [.clear, .loadTopItems])
    }

    // MARK: - Router
    func testShowFullImage() throws {
        let posts = try filledData()
        sut.didLoad(posts: posts)

        XCTAssertEqual(mockRouter.shownImageLinks, [], "precondition")

        mockView.props.state.posts?.first?.onSelect?.perform()
        
        XCTAssertEqual(mockRouter.shownImageLinks, [posts.first?.data.imageLink])
    }
    
    // MARK: - Helpers
    private func filledData() throws -> [Child] {
        guard let url = Bundle.main.url(forResource: "TopItemsTestData",
                                        withExtension: "json") else {
            throw BaseError(code: 0, message: "Missing TopItemsTestData.json")
        }

        let jsonData = try Data(contentsOf: url)
        let topItems = try JSONDecoder().decode(TopItems.self, from: jsonData)

        return topItems.data.children
    }
}

private final class MockTopItemsView: TopItemsViewProtocol {
    var props: TopItemsProps = .initial
    private(set) var shownErrors = [String]()

    func showError(with text: String) {
        shownErrors.append(text)
    }
}

private final class MockTopItemsInteractor: TopItemsInteractorInputProtocol {
    enum Message {
        case loadTopItems
        case loadMoreItems
        case clear
    }
    
    private(set) var messages = [Message]()
    
    func loadTopItems() {
        messages.append(.loadTopItems)
    }

    func loadMoreItems() {
        messages.append(.loadMoreItems)
    }

    func clear() {
        messages.append(.clear)
    }
}

private final class MockTopItemsRouter: TopItemsRouterProtocol {
    private(set) var shownImageLinks = [String]()

    func showFullImage(with link: String) {
        shownImageLinks.append(link)
    }
}

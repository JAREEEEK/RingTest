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

    override func setUp() {
        mockView = MockTopItemsView()
        
        sut = TopItemsPresenter(interface: mockView)
        
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockView = nil
    }

    // MARK: - View
    func testLoadingStateWhenRefreshData() {
        XCTAssertFalse(mockView.props.state.isLoading, "precondition")

        sut.didStartLoading(cancel: {})

        XCTAssertTrue(mockView.props.state.isLoading)
    }

    func testUpdatesViewWhenTopItemsReturned() throws {
        sut.didStartLoading(cancel: {})

        XCTAssertTrue(mockView.props.state.isLoading, "precondition")
        
        sut.didLoad(posts: try filledData(), after: nil, next: {})

        XCTAssertFalse(mockView.props.state.isLoading)
    }
    
    func testReplacesPostsWhenTopItemsReturned() throws {
        let posts = try filledData()
        
        XCTAssertTrue(mockView.props.posts.isEmpty, "precondition")
        
        sut.didLoad(posts: posts, after: nil, next: {})
        
        XCTAssertEqual(mockView.props.posts.count, posts.count)
        
        sut.didLoad(posts: posts, after: nil, next: {})

        XCTAssertEqual(mockView.props.posts.count, posts.count)
    }
    
    func testAppendsPostsWhenMoreItemsReturned() throws {
        let posts = try filledData()
        
        XCTAssertTrue(mockView.props.posts.isEmpty, "precondition")
        
        sut.didLoad(posts: posts, after: nil, next: {})

        XCTAssertEqual(mockView.props.posts.count, posts.count)
        
        let lastId = mockView.props.posts.last?.elementId
        sut.didLoad(posts: posts, after: lastId, next: {})

        XCTAssertEqual(mockView.props.posts.count, posts.count * 2)
    }
    
    func testUpdatesViewWhenMoreItemsReturned() throws {
        sut.didStartLoading(cancel: {})

        XCTAssertTrue(mockView.props.state.isLoading, "precondition")
        
        sut.didLoad(posts: try filledData(), after: "any", next: {})

        XCTAssertFalse(mockView.props.state.isLoading)
    }

    func testWhenFailureItShowsError() {
        XCTAssertEqual(mockView.shownErrors, [], "precondition")

        sut.didFailLoading(with: BaseError(code: -1, message: "Empty error"))

        XCTAssertEqual(mockView.shownErrors, ["Empty error"])
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

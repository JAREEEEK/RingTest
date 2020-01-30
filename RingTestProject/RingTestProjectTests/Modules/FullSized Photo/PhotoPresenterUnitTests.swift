//
//  PhotoPresenterUnitTests.swift
//  RingTestProjectTests
//
//  Created by Yaroslav Nosik on 30.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import XCTest
@testable import RingTestProject

class PhotoPresenterUnitTests: XCTestCase {
    var presenter: PhotoPresenter?
    fileprivate var mockView: MockPhotoView?
    fileprivate var mockInteractor: MockPhotoInteractor?
    fileprivate var mockRouter: MockPhotoRouter?

    override func setUp() {
        self.mockView = MockPhotoView()
        self.mockInteractor = MockPhotoInteractor()
        self.mockRouter = MockPhotoRouter()
        guard let mockView = mockView,
            let mockInteractor = mockInteractor,
            let mockRouter = mockRouter else { return }

        self.presenter = PhotoPresenter(link: "test",
                                        interface: mockView,
                                        interactor: mockInteractor,
                                        router: mockRouter)
        self.mockInteractor?.presenter = self.presenter

        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        self.presenter = nil
        self.mockView = nil
        self.mockInteractor = nil
        self.mockRouter = nil
    }

    // MARK: - View
    func testWhenFailureItShowsError() {
        guard let mockView = mockView else { return }
        self.mockInteractor?.fail = true
        self.presenter?.viewIsReady()
        self.mockView?.props.didPushSaveButton.perform()
        XCTAssertTrue(mockView.didShowError)
    }

    func testLoadingStateWhenSaveImage() {
        guard let mockView = mockView else { return }
        self.mockInteractor?.noReturn = true
        self.presenter?.viewIsReady()
        self.mockView?.props.didPushSaveButton.perform()
        XCTAssertTrue(mockView.props.state.isLoading)
    }

    func testWhenShowsLinkData() {
        guard let mockView = mockView else { return }
        self.presenter?.viewIsReady()
        XCTAssertTrue(mockView.props.state.photo != nil)
    }

    // MARK: - Interactor
    func testInteractorStartsSavingImage() {
        guard let interactor = mockInteractor else { return }
        self.presenter?.viewIsReady()
        self.mockView?.props.didPushSaveButton.perform()
        XCTAssertTrue(interactor.processing)
    }

    func testInteractorStartsCancel() {
        guard let interactor = mockInteractor else { return }
        self.presenter?.viewIsReady()
        self.mockView?.props.didPushSaveButton.perform()
        XCTAssertTrue(interactor.processing)
    }
}

fileprivate final class MockPhotoView: PhotoViewProtocol {
    var props: PhotoProps = .initial
    var didShowError = false

    func showError(with text: String) {
        didShowError = true
    }
}

fileprivate final class MockPhotoInteractor: PhotoInteractorInputProtocol {
    var processing = false
    var fail = false
    var noReturn = false
    var presenter: PhotoInteractorOutputProtocol?
    var didCancelLoading = false

    func loadImage(with link: String) {
        self.processing = true
        guard !noReturn else { return }
        if fail {
            self.presenter?.didFailLoading(with: "Error")
        } else {
            self.presenter?.didLoad(image: #imageLiteral(resourceName: "placeholder"))
        }
    }

    func cancel() {
        didCancelLoading = true
    }
}

fileprivate final class MockPhotoRouter: PhotoRouterProtocol {
    var didDismiss = false

    func dismiss() {
        didDismiss = true
    }
}

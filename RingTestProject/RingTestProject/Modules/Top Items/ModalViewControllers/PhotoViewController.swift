//
//  PhotoViewController.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class PhotoViewController: BaseViewController, PhotoViewProtocol {
    // MARK: - Props
    var props: PhotoProps = .initial {
        didSet {
            self.view.setNeedsLayout()
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    // MARK: - Dependencies
	var presenter: PhotoPresenterProtocol?

    // MARK: - View controller lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if let zoomImage = imageView.image {
            setMinZoomScaleForImageSize(zoomImage.size)
        }
        self.setupState()
    }

    // MARK: - Private functions
    private func setupState() {
        switch props.state {
        case .loading:
            self.showActivityView()
        case .photo(let image):
            self.imageView.image = image
            self.hideActivityView()
        }
    }

    private func setMinZoomScaleForImageSize(_ imageSize: CGSize) {
        let widthScale = view.frame.width / imageSize.width
        let heightScale = view.frame.height / imageSize.height
        let minScale = min(widthScale, heightScale)

        // Scale the image down to fit in the view
        imageScrollView.minimumZoomScale = minScale
        imageScrollView.zoomScale = minScale

        // Set the image frame size after scaling down
        let imageWidth = imageSize.width * minScale
        let imageHeight = imageSize.height * minScale
        let newImageFrame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        imageView.frame = newImageFrame

        centerImage()
    }

    private func centerImage() {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = view.frame.size
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0

        imageScrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
}

extension PhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
}

//
//  PhotoInteractor.swift
//  RingTestProject
//
//  Created Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.

import UIKit

final class PhotoInteractor: PhotoInteractorInputProtocol {

    weak var presenter: PhotoInteractorOutputProtocol?
    private var loader: AsyncImage?

    func loadImage(with link: String) {
        self.loader = AsyncImage(url: link)
        self.loader?.completeDownload = { [weak self] image in
            if let image = image {
                self?.presenter?.didLoad(image: image)
            } else {
                let error = CustomError.noImage
                self?.presenter?.didFailLoading(with: error.errorDescription.valueOrEmpty)
            }
        }

        self.loader?.startDownloading()
    }

    func cancel() {
        loader?.cancelDownloading()
    }
}

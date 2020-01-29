//
//  AsyncImage.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

class AsyncImage {
    let url: URL

    var image: UIImage {
        return self.imageStore ?? placeholder
    }

    var completeDownload: ((UIImage?) -> Void)?

    private var imageStore: UIImage?
    private var placeholder: UIImage

    private let imageDownloadHelper: ImageDownloadHelperProtocol

    private var isDownloading: Bool = false

    init(url: String,
         placeholderImage: UIImage = #imageLiteral(resourceName: "imagePlaceholder") ,
         imageDownloadHelper: ImageDownloadHelperProtocol = ImageDownloadHelper()) {
        self.url = URL(string: url)!
        self.placeholder = placeholderImage
        self.imageDownloadHelper = imageDownloadHelper
    }

    func startDownload() {
        if imageStore != nil {
            completeDownload?(image)
        } else {
            if isDownloading { return }
            isDownloading = true
            imageDownloadHelper.download(url: url, completion: { [weak self] (image, response, error) in
                self?.imageStore = image
                self?.isDownloading = false
                DispatchQueue.main.async {
                    self?.completeDownload?(image)
                }
            })
        }
    }
}

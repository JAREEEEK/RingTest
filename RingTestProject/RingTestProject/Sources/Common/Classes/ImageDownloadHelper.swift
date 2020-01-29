//
//  ImageDownloadHelper.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

protocol ImageDownloadHelperProtocol {
    func download(url: URL, completion: @escaping (UIImage?, URLResponse?, Error?) -> ())
    func cancel()
}

class ImageDownloadHelper: ImageDownloadHelperProtocol {
    private let urlSession: URLSession = URLSession.shared
    private var dataTask: URLSessionDataTask?

    func download(url: URL, completion: @escaping (UIImage?, URLResponse?, Error?) -> ()) {
        dataTask = urlSession.dataTask(with: url) { data, response, error in
            if let data = data {
                completion(UIImage(data: data), response, error)
            } else {
                completion(nil, response, error)
            }
        }

        dataTask?.resume()
    }

    func cancel() {
        dataTask?.cancel()
    }
}

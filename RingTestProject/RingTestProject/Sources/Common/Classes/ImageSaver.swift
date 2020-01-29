//
//  ImageSaver.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

final class ImageSaver: NSObject {
    private var completion: ((UIImage, Error?) -> ())?

    func writeToPhotoAlbum(image: UIImage, completion: @escaping ((UIImage, Error?) -> ())) {
        self.completion = completion
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc private func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        self.completion?(image, error)
    }
}

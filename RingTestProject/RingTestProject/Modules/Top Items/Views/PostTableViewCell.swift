//
//  PostTableViewCell.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

final class PostTableViewCell: UITableViewCell, TableCell {
    @IBOutlet weak var thumbnailImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var thumbnailButton: UIButton!
    private var model: PostViewModel?

    var onSelection: ((PostViewModel) -> Void)?
    
    @IBAction func didTapThumbnailButton(_ sender: UIButton) {
        guard let model = model else { return }
        self.onSelection?(model)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImageView?.image = nil
        self.titleLabel?.text = nil
        self.authorLabel?.text = nil
        self.timeLabel?.text = nil
        self.commentsLabel?.text = nil
    }

    func setup(with element: TableElement) {
        self.model = element.model

        let model = element.model
        self.titleLabel.text = model.title
        self.authorLabel.text = model.author
        self.timeLabel.text = model.createdAt
        self.commentsLabel.text = model.comments
        self.thumbnailImageView?.image = model.photo.image
        model.photo.completeDownload = { [weak self] image in
            self?.thumbnailButton.isUserInteractionEnabled = image != nil
            guard let image = image else { return }
            self?.thumbnailImageView?.image = image
        }

        model.photo.startDownloading()
    }
}

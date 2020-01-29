//
//  PostViewModel.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import UIKit

final class PostViewModel {
    let title: String
    let author: String
    let createdAt: String
    let comments: String
    let photo: AsyncImage

    init(post: Post) {
        let date = Date(timeIntervalSince1970: post.created.valueOrEmpty)
        self.title = post.title.valueOrEmpty
        self.author = "Posted by \(post.author.valueOrEmpty)"
        self.createdAt = date.getDiffStringTime()
        self.comments = "\(post.numberOfComments.valueOrEmpty) comments"
        self.photo = AsyncImage(url: post.thumbnailWebLink.valueOrEmpty)
    }
}

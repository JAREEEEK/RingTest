//
//  PostViewModel.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation

final class PostViewModel {
    let title: String?
    let author: String?
    let createdAt: String?
    let comments: String?

    init(title: String?, author: String?, createdAt: String?, comments: String?) {
        self.title = title
        self.author = author
        self.createdAt = createdAt
        self.comments = comments
    }
}

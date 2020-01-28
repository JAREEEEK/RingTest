//
//  Post.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation

// MARK: - PostData
struct TopItems: Codable {
    let kind: String
    let data: PostData
}

// MARK: - PostData
struct PostData: Codable {
    let modhash: String
    let dist: Int
    let children: [Child]
    let after: String?
    let before: String?
}

// MARK: - Child
struct Child: Codable {
    let kind: String
    let data: Post
}

// MARK: - Post
struct Post: Codable {
    var postId: String
    var title: String?
    var author: String?
    var created: String?
    var thumbnailWebLink: String?
    var preview: Preview?
    var numberOfComments: Int?
    var link: String?

    private enum CodingKeys: String, CodingKey {
        case postId = "id"
        case title, author, preview
        case link  = "url"
        case created = "created_utc"
        case thumbnailWebLink = "thumbnail"
        case numberOfComments = "num_comments"
    }
}

// MARK: - Preview
struct Preview: Codable {
    let images: [Image]
    let enabled: Bool
}

// MARK: - Image
struct Image: Codable {
    let imageId: String
    let source: ResizedIcon?
    let resolutions: [ResizedIcon]?

    private enum CodingKeys: String, CodingKey {
        case imageId = "id"
        case source, resolutions
    }
}

// MARK: - ResizedIcon
struct ResizedIcon: Codable {
    let url: String
    let width, height: Int
}

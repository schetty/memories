//
//  File.swift
//  Memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import Foundation

//"albumId": 1,
//    "id": 32,
//    "title": "ad enim dignissimos voluptatem similique",
//    "url": "https://via.placeholder.com/600/c70a4d",
//    "thumbnailUrl": "https://via.placeholder.com/150/c70a4d"

struct Album: Identifiable, Decodable {
    public var albumId: Int
    public var id: Int
    public var title: String
    public var url: String
    public var thumbnailUrl: String
}

//
//  MemoryModel.swift
//  photoapp
//
//  Created by Prisha on 20/04/26.
//

import Foundation

enum MemoryType {
    case album
    case video
}

struct Friend: Identifiable {
    let id = UUID()
    let name: String
    let avatar: String
}

struct Memory: Identifiable {
    let id = UUID()
    var title: String
    var coverImage: String
    var type: MemoryType
    var participants: [Friend]
    var items: [ImageItem]
}


let mockFriends: [Friend] = [
    Friend(name: "Willy", avatar: "photo_10"),
    Friend(name: "Calvin", avatar: "photo_11"),
    Friend(name: "Daffa", avatar: "photo_12")
]

let mockMemories: [Memory] = [
    Memory(
        title: "Bali Trip",
        coverImage: "photo_13",
        type: .video,
        participants: mockFriends,
        items: imagesMock
    ),
    Memory(
        title: "Beach Days",
        coverImage: "photo_14",
        type: .album,
        participants: mockFriends,
        items: imagesMock
    )
]

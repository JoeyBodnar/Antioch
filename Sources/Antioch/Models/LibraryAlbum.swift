//
//  LibraryAlbum.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/22/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public final class LibraryAlbum: AppleMusicResource<LibraryAlbumAttributes, LibraryAlbumRelationships> {
    
    public override init(id: String, type: AppleMusicItemType) {
        super.init(id: id, type: .libraryAlbums)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

public final class LibraryAlbumAttributes: Decodable {
    public let artistName: String
    public var artwork: Artwork?
    public let name: String
    public var playParams: PlayParameters
    public let trackCount: Int
}

public final class LibraryAlbumRelationships: Decodable {
    public let tracks: Relationship<LibrarySong>
}

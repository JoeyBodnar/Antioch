//
//  LibraryPlaylist.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/22/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public final class LibraryPlaylist: AppleMusicResource<LibraryPlaylistAttributes, LibraryPlaylistRelationships> {
    
    public override init(id: String, type: AppleMusicItemType) {
        super.init(id: id, type: .libraryPlaylists)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

extension LibraryPlaylist: LibraryQueryable { }

extension LibraryPlaylist: Rateable { }

public final class LibraryPlaylistAttributes: Decodable {
    public var artwork: Artwork?
    public let canEdit: Bool
    public let name: String
    public let playParams: PlayParameters
    public var globalID: String?
}

/// in theory this should have songs, but actually the apple music api does not return the songs
public class LibraryPlaylistRelationships: Decodable {
    
}

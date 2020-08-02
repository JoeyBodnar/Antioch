//
//  AppleMusicLibrarySong.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/19/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public final class LibrarySong: AppleMusicResource<LibrarySongAttributes, NilRelationship> {
    
    public override init(id: String, type: AppleMusicItemType) {
        super.init(id: id, type: .librarySongs)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

extension LibrarySong: LibraryQueryable { }

extension LibrarySong: Rateable { }

public final class LibrarySongAttributes: Decodable {
    public var albumName: String?
    public var artistName: String?
    public var artwork: Artwork?
    public let name: String
    public let playParams: PlayParameters
    public let trackNumber: Int
}


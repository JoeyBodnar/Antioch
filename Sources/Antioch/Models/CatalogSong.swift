//
//  CatalogSong.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/19/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public class CatalogSong: AppleMusicResource<CatalogSongAttributes, CatalogSongRelationships> {
    
    public override init(id: String, type: AppleMusicItemType) {
        super.init(id: id, type: .songs)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

extension CatalogSong: Rateable { }

extension CatalogSong: CatalogQueryable { }

public final class CatalogSongAttributes: Decodable {
    public var albumName: String?
    public var artistName: String?
    public var artwork: Artwork?
    public var composerName: String?
    public var discNumber: Int?
    public var durationInMillis: Int?
    public var genreNames: [String]?
    public var isrc: String?
    public let name: String
    public let playParams: PlayParameters?
    public let releaseDate: String?
    public let trackNumber: Int
    public let url: String
    public var contentRating: String?
}

public final class CatalogSongRelationships: Decodable {
    public let albums: Relationship<CatalogAlbum>
    public let artists: Relationship<CatalogArtist>
}

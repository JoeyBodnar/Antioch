//
//  RecentTrack.swift
//  AppleMusicKit
//
//  Created by Stephen Bodnar on 10/1/22.
//

import Foundation

public enum RecentTrack: Decodable {
    case song(song: CatalogSong)
    case librarySong(song: LibrarySong)
    case unknown
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let type: String = try container.decode(String.self, forKey: .type)
        switch type {
        case AppleMusicItemType.songs.rawValue:
            let catalogSong: CatalogSong = try CatalogSong(from: decoder)
            self = .song(song: catalogSong)
        case AppleMusicItemType.librarySongs.rawValue:
            let librarySong: LibrarySong = try LibrarySong(from: decoder)
            self = .librarySong(song: librarySong)
        default:
            print("Decoding error: Unexpected type \(type), recent track will be unknown")
            self = .unknown
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case type
    }
}

public final class RecentTracksResponse: Decodable {
    let data: [RecentTrack]
    
    init(data: [RecentTrack]) {
        self.data = data
    }
}

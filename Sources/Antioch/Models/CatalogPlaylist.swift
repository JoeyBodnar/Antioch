import Foundation

public class CatalogPlaylist: AppleMusicResource<CatalogPlaylistAttributes, CatalogPlaylistRelationships> {
    
    public var songs: [CatalogSong] {
        return relationships?.tracks?.data ?? []
    }
    
    public override init(id: String, type: AppleMusicItemType) {
        super.init(id: id, type: .playlists)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

extension CatalogPlaylist: CatalogQueryable { }

extension CatalogPlaylist: Rateable { }

public class CatalogPlaylistAttributes: Decodable {
    public var artwork: Artwork?
    public let curatorName: String?
    public let lastModifiedDate: String?
    public var name: String
    public let playParams: PlayParameters?
    public let playlistType: String
    public let url: String
}

public class CatalogPlaylistRelationships: Decodable {
    public let tracks: Relationship<CatalogSong>?
    public let curator: Relationship<Curator>?
}

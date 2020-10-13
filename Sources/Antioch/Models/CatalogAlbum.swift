import Foundation

public class CatalogAlbum: AppleMusicResource<CatalogAlbumAttributes, CatalogAlbumRelationships> {
    
    public var songs: [CatalogSong] {
        return relationships?.tracks.data ?? []
    }
    
    public override init(id: String, type: AppleMusicItemType) {
        super.init(id: id, type: .albums)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

extension CatalogAlbum: CatalogQueryable { }

extension CatalogAlbum: Rateable { }

public final class CatalogAlbumAttributes: Decodable {
    public let artistName: String
    public var artwork: Artwork?
    public let copyright: String
    public var editorialNotes: EditorialNotes?
    public var genreNames: [String]?
    public var isComplete: Bool?
    public var isMasteredForItunes: Bool?
    public var isSingle: Bool?
    public let name: String
    public var playParams: PlayParameters
    public let recordLabel: String
    public let releaseDate: String?
    public let trackCount: Int
    public let url: String
}

public final class CatalogAlbumRelationships: Decodable {
    public let artists: Relationship<CatalogArtist>
    public let tracks: Relationship<CatalogSong>
}

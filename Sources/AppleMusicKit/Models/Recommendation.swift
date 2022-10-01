import Foundation

public final class Recommendation: AppleMusicResource<RecommendationAttributes, RecommendationRelationships> {
    
    override init(id: String, type: AppleMusicItemType) {
        super.init(id: id, type: .personalRecommendation)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

public final class RecommendationAttributes: Decodable {
    public let isGroupRecommendation: Bool
    public var title: RecommendationTitle
    public var reason: String?
    public let resourceTypes: [String]
    public var nextUpdateDate: String?
}

public final class RecommendationTitle: Decodable {
    public var stringForDisplay: String
}

public final class RecommendationRelationships: Decodable {
    public var contents: RecommendationRelationShipContents
}

public enum RecommendationItem: Decodable {
    case playlist(playlist: CatalogPlaylist)
    case album(album: CatalogAlbum)
    case song(song: CatalogSong)
    case station(station: RadioStation)
    
    case unknown
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let type: String = try container.decode(String.self, forKey: .type)
        switch type {
        case AppleMusicItemType.songs.rawValue:
            let catalogSong: CatalogSong = try CatalogSong(from: decoder)
            self = .song(song: catalogSong)
        case AppleMusicItemType.albums.rawValue:
            let album: CatalogAlbum = try CatalogAlbum(from: decoder)
            self = .album(album: album)
        case AppleMusicItemType.playlists.rawValue:
            let playlist: CatalogPlaylist = try CatalogPlaylist(from: decoder)
            self = .playlist(playlist: playlist)
        case AppleMusicItemType.stations.rawValue:
            let station: RadioStation = try RadioStation(from: decoder)
            self = .station(station: station)
        default:
            print("Decoding error: Unexpected recommendation type \(type), recent track will be unknown")
            self = .unknown
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case type
    }
}

public final class RecommendationRelationShipContents: Decodable {
    public var data: [RecommendationItem]
}

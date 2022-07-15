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

public final class RecommendationRelationShipContents: Decodable {
    public var data: [Any]
    
    public init(from decoder: Decoder) throws {
        guard var container = try? decoder.container(keyedBy: CodingKeys.self).nestedUnkeyedContainer(forKey: .data) else {
            self.data = []
            return
        }
      
        var items = [Any]()
        
        while !container.isAtEnd {
            
            guard let itemContainer = try? container.nestedContainer(keyedBy: CodingKeys.self),
                let type = try? itemContainer.decode(String.self, forKey: .type) else {
                self.data = []
                return
            }
            switch type {
            case AppleMusicItemType.playlists.rawValue:
                do {
                    let id = try itemContainer.decode(String.self, forKey: .id)
                    let attributes: CatalogPlaylistAttributes = try itemContainer.decode(CatalogPlaylistAttributes.self, forKey: .attributes)
                    let playlist = CatalogPlaylist(id: id, type: .playlists)
                    playlist.attributes = attributes
                    items.append(playlist)
                } catch { } // do nothing. We just won't append this to the items then
                
            case AppleMusicItemType.albums.rawValue:
                do {
                    let id = try itemContainer.decode(String.self, forKey: .id)
                    let attributes: CatalogAlbumAttributes = try itemContainer.decode(CatalogAlbumAttributes.self, forKey: .attributes)
                    let album = CatalogAlbum(id: id, type: .albums)
                    album.attributes = attributes
                    items.append(album)
                } catch { } // do nothing. We just won't append this to the items then
                
            case AppleMusicItemType.songs.rawValue:
                do {
                    let id = try itemContainer.decode(String.self, forKey: .id)
                    let attributes: CatalogSongAttributes = try itemContainer.decode(CatalogSongAttributes.self, forKey: .attributes)
                    let song = CatalogSong(id: id, type: .songs)
                    song.attributes = attributes
                    items.append(song)
                } catch { } // do nothing. We just won't append this to the items then
                
            default:
                print("test:: it is the default: \(type)")
            }
        }

        self.data = items
    }
    
    private enum CodingKeys: String, CodingKey {
        case data
        case type
        
        case id
        case attributes
    }
}

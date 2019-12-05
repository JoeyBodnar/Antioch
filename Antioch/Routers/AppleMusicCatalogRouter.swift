public enum CatalogRouter: Provider {
    
    /// get a catalog playlist, album, song, or artist
    case getCatalogResource(CatalogQueryable.Type, String)
    case getMultipleCatalogResources(CatalogQueryable.Type, [String]) // string is array of ids
    
    /// string value is the storefront. Used so you can retrieve different countries' charts
    case charts([IncludeParameter], Int, String = Antioch.shared.storeFront) // types, limit, offset, storeFront
  
    /// Get charts for a specific genre
    case chartsForGenre(AppleMusicGenre, [IncludeParameter], Int) // genre, types, limit
    
    public var path: String {
        switch self {
        case .getCatalogResource(let resource, let id):
            return "\(baseURL)\(getResourcePath(for: resource))/\(id)"
        case .getMultipleCatalogResources(let resource, let ids):
            let joinedIds = ids.joined(separator: ",") // of syntax id1,id2,id3 etc
            return "\(baseURL)\(getResourcePath(for: resource))?ids=\(joinedIds)"
        case .charts(let types, let limit, let storeFront):
            let allTypes = types.asString()
            let base = "\(RoutingConstants.appleMusicBaseURL)/catalog/\(storeFront)/"
            return "\(base)charts?types=\(allTypes)&limit=\(limit)"
        case .chartsForGenre(let genre, let types, let limit):
            let types = types.asString()
            return "\(baseURL)charts?types=\(types)&genre=\(genre.id)&limit=\(limit)"
        }
    }
    
    internal var baseURL: String {
        return "\(RoutingConstants.appleMusicBaseURL)/catalog/\(Antioch.shared.storeFront)/"
    }
    
    fileprivate func getResourcePath(for type: CatalogQueryable.Type) -> String {
        if type == CatalogSong.self {
            return AppleMusicItemType.songs.rawValue
        } else if type == CatalogArtist.self {
            return AppleMusicItemType.artists.rawValue
        } else if type == CatalogPlaylist.self {
            return AppleMusicItemType.playlists.rawValue
        } else if type == CatalogAlbum.self {
            return AppleMusicItemType.albums.rawValue
        } else if type == RadioStation.self {
            return AppleMusicItemType.stations.rawValue
        } else {
            return "-"
        }
    }
}

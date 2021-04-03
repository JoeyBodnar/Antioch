public enum CatalogRouter: Provider {
    
    /// get a catalog playlist, album, song, or artist
    case getCatalogResource(type: CatalogQueryable.Type, id: String, storefront: String)
    case getMultipleCatalogResources(type: CatalogQueryable.Type, ids: [String], storefront: String)
    
    /// string value is the storefront. Used so you can retrieve different countries' charts
    case charts(types: [IncludeParameter], limit: Int, storefront: String) // types, limit, storeFront
  
    /// Get charts for a specific genre
    case chartsForGenre(genre: AppleMusicGenre, types: [IncludeParameter], limit: Int, storefront: String) // genre, types, limit
    
    public var path: String {
        switch self {
        case .getCatalogResource(let resource, let id, let storefront):
            return "\(baseURL)\(storefront)/\(getResourcePath(for: resource))/\(id)"
        case .getMultipleCatalogResources(let resource, let ids, let storefront):
            let joinedIds = ids.joined(separator: ",") // of syntax id1,id2,id3 etc
            return "\(baseURL)\(storefront)/\(getResourcePath(for: resource))?ids=\(joinedIds)"
        case .charts(let types, let limit, let storeFront):
            let allTypes = types.asString()
            let base = "\(RoutingConstants.appleMusicBaseURL)/catalog/\(storeFront)/"
            return "\(base)charts?types=\(allTypes)&limit=\(limit)"
        case .chartsForGenre(let genre, let types, let limit, let storefront):
            let types = types.asString()
            return "\(baseURL)\(storefront)/charts?types=\(types)&genre=\(genre.id)&limit=\(limit)"
        }
    }
    
    internal var baseURL: String {
        return "\(RoutingConstants.appleMusicBaseURL)/catalog/"
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

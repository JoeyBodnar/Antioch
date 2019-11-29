//
//  AppleMusicCatalogRouter.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/19/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public enum CatalogRouter: Provider {
    
    /// get a catalog playlist, album, song, or artist
    case getCatalogResource(CatalogQueryable.Type, String)
    case getMultipleCatalogResources(CatalogQueryable.Type, [String]) // string is array of ids
    
    case charts([IncludeParameter], Int) // types, limit, offset
  
    public var path: String {
        switch self {
        case .getCatalogResource(let resource, let id):
            return "\(baseURL)\(getResourcePath(for: resource))/\(id)"
        case .getMultipleCatalogResources(let resource, let ids):
            let joinedIds = ids.joined(separator: ",") // of syntax id1,id2,id3 etc
            return "\(baseURL)\(getResourcePath(for: resource))?ids=\(joinedIds)"
        case .charts(let types, let limit):
            let allTypes = types.asString()
            return "\(baseURL)charts?types=\(allTypes)&limit=\(limit)"
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

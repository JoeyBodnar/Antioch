//
//  AppleMusicLibraryRouter.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/19/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public enum LibraryRouter: Provider {
    
    case getLibraryResource(LibraryQueryable.Type, String) // string is id
    case getMultipleLibraryResources(LibraryQueryable.Type, [String]) // string is array of ids
    
    case getAllLibrayResources(LibraryQueryable.Type, Int, Int) // Int, Int are limit and offset
    
    case addItemsToLibrary([AddableItem])
    case recommendations
    
    /// Unfortunately, the Apple Music API does not give us the songs along with the library playlist. We have to fetch them separately
    case songsForPlaylist(String, Int, Int) // playlistId, limit, offset
    case addItemsToPlaylist(String) // playlistId
    
    public var path: String {
        switch self {
        case .getLibraryResource(let resource, let id):
            return "\(baseURL)library/\(getResourcePath(for: resource))/\(id)"
        case .getMultipleLibraryResources(let resource, let ids):
            let joinedIds = ids.joined(separator: ",")
            return "\(baseURL)library/\(getResourcePath(for: resource))?ids=\(joinedIds)"
        case .getAllLibrayResources(let resource, let limit, let offset):
            return "\(baseURL)library/\(getResourcePath(for: resource))?limit=\(limit)&offset=\(offset)"
        case .recommendations:
            return "\(baseURL)recommendations"
        case .songsForPlaylist(let id, let limit, let offset):
            return "\(baseURL)library/playlists/\(id)/tracks?limit=\(limit)&offset=\(offset)"
        case .addItemsToLibrary(let items):
            return "\(baseURL)library?\(pathForAddItem(withItems: items))"
        case .addItemsToPlaylist(let playlistId):
            return "\(baseURL)library/playlists/\(playlistId)/tracks"
        }
    }
    
    internal var baseURL: String {
        return "\(RoutingConstants.appleMusicBaseURL)/me/"
    }
    
    fileprivate func getResourcePath(for type: LibraryQueryable.Type) -> String {
        if type == LibrarySong.self {
            return "songs"
        } else if type == LibraryAlbum.self {
            return "albums"
        } else if type == LibraryPlaylist.self {
            return "playlists"
        } else if type == LibraryArtist.self {
            return "artists"
        } else {
            return "-"
        }
    }
    
    // Example path: ids[albums]=1106659171&ids[songs]=1107054256&ids[music-videos]=267079116
    internal func pathForAddItem(withItems items: [AddableItem]) -> String {
        var path = ""
        var index = 0
        for i in items {
            let idsJoined = i.ids.joined(separator: ",")
            path += "ids[\(i.type.rawValue)]=\(idsJoined)"
            
            if index < (items.count - 1) {
                path += "&"
            }
            
            index += 1
        }
        
        return path
    }
}

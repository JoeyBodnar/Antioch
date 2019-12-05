//
//  APIManagerLibrary.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/25/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

extension Antioch {
    
    /// Get a library song using its id
    public func librarySong(forId id: String, completion: DataCompletion<LibrarySong>) {
        libraryItem(forId: id, ofType: LibrarySong.self) { item, error in
            completion?(item, error)
        }
    }
    
    /// Get a library playlist using its id
    public func libraryPlaylist(forId id: String, completion: DataCompletion<LibraryPlaylist>) {
        libraryItem(forId: id, ofType: LibraryPlaylist.self) { item, error in
            completion?(item, error)
        }
    }
    
    /// Get the songs for a library playlsit by passing in the playlist's id. We need this method because
    /// when you retrieve a library playlist, the API does not pass back the songs with it. So we need to retrieve them separately
    public func songs(forLibraryPlaylistId playlistId: String, withLimit limit: Int, andOffset offset: Int, completion: DataCompletion<[LibrarySong]>) {
        let request = AntiochRequest(endPoint: LibraryRouter.songsForPlaylist(playlistId, limit, offset), method: .get)
        performRequest(request: request, forResponseType: LibrarySong.self) { result in
            switch result {
            case .success(let response):
                completion?(response?.data, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    /// Add items to your library by passing in an array of AddableItem objects
    public func addToLibrary(items: [AddableItem], completion: ((_ success: Bool, _ error: Error?) -> Void)?) {
        let request = AntiochRequest(endPoint: LibraryRouter.addItemsToLibrary(items), method: .post)
        performRequestforVoidResponse(request: request) { success, error in
            completion?(success, error)
        }
    }
    
    /// Add songs to a playlist. Pass in the playlist id and the ids of the songs.
    public func addToPlaylist(itemIds: [String], toPlaylistWithId playlistId: String, completion: VoidResponseCompletion) {
        let request = AntiochRequest(endPoint: LibraryRouter.addItemsToPlaylist(playlistId), method: .post)
        
        let body = itemIds.map { id -> [String: String] in
            return ["id" : id, "type": "songs"]
        }
        
        request.params = ["data": body]
        performRequestforVoidResponse(request: request) { success, error in
           completion?(success, error)
        }
    }
    
    /// Get a library item of type T using its id
    public func libraryItem<T: Decodable & LibraryQueryable>(forId id: String, ofType type: T.Type, completion: DataCompletion<T>) {
        let request = AntiochRequest(endPoint: LibraryRouter.getLibraryResource(type, id), method: .get)
        performRequest(request: request, forResponseType: type) { result in
            switch result {
            case .success(let retrievedItem):
                completion?(retrievedItem?.data?.first, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    /// Get all library items of type T. Max and default limit is 100.
    public func allLibraryItems<T: Decodable & LibraryQueryable>(ofType type: T.Type, withLimit limit: Int, andOffset offset: Int, completion: CollectionDataCompletion<T>) {
        let request = AntiochRequest(endPoint: LibraryRouter.getAllLibrayResources(type, limit, offset), method: .get)
        performRequest(request: request, forResponseType: type) { (result) in
            switch result {
            case .success(let items):
                completion?(items?.data, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    /// Get the user's recommendations
    public func recommendations(completion: CollectionDataCompletion<Recommendation>) {
        let request = AntiochRequest(endPoint: LibraryRouter.recommendations, method: .get)
        performRequest(request: request, forResponseType: Recommendation.self) { result in
            switch result {
            case .success(let recommendation):
                completion?(recommendation?.data, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
}

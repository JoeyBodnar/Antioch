//
//  APIManagerCatalog.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/25/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

extension Antioch {
    
    /// Get a song from the Apple Music catalog by its id
    public func catalogSong(forId id: String, completion: DataCompletion<CatalogSong>) {
        catalogItem(forId: id, ofType: CatalogSong.self) { (song, error) in
            completion?(song, error)
        }
    }
    /// Get a catalog playlist from the Apple Music catalog by its id
    public func catalogPlaylist(forId id: String, completion: DataCompletion<CatalogPlaylist>) {
        catalogItem(forId: id, ofType: CatalogPlaylist.self) { playlist, error in
            completion?(playlist, error)
        }
    }
    
    /// Get an item of type T from the Apple Music Catalog by its id
    public func catalogItem<T: Decodable & CatalogQueryable>(forId id: String, ofType type: T.Type, completion: DataCompletion<T>) {
        let request = AntiochRequest(endPoint: CatalogRouter.getCatalogResource(type, id), method: .get)
        performRequest(request: request, forResponseType: type) { result in
            switch result {
            case .success(let response):
                completion?(response?.data?.first, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    /// Pass in an array of ids and their type, and  get the  catalog items.
    public func catalogItems<T: Decodable & CatalogQueryable>(forIds ids: [String], ofType type: T.Type, completion: CollectionDataCompletion<T>) {
        let request = AntiochRequest(endPoint: CatalogRouter.getMultipleCatalogResources(type, ids), method: .get)
        performRequest(request: request, forResponseType: type) { (result) in
            switch result {
            case .success(let response):
                completion?(response?.data, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    /// Get the Apple Music catalog charts. Valid values for the types parameter  are songs, playlists, and albums
    public func charts(types: [IncludeParameter], withLimit limit: Int, completion: DataCompletion<ChartResponse>) {
        let request = AntiochRequest(endPoint: CatalogRouter.charts(types, limit), method: .get)
        performRequest(request: request, forResponseType: ChartResponse.self) { result in
            switch result {
            case .success(let response):
                completion?(response?.results, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
}

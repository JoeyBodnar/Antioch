import Foundation

extension Antioch {
    
    /// Get a song from the Apple Music catalog by its id
    public func catalogSong(forId id: String, completion: DataCompletion<CatalogSong>) {
        catalogItem(forId: id, ofType: CatalogSong.self, completion: completion)
        /*catalogItem(forId: id, ofType: CatalogSong.self) { (song, error) in
            completion?(song, error)
        }*/
    }
    /// Get a catalog playlist from the Apple Music catalog by its id
    public func catalogPlaylist(forId id: String, completion: DataCompletion<CatalogPlaylist>) {
        catalogItem(forId: id, ofType: CatalogPlaylist.self, completion: completion)
        /*catalogItem(forId: id, ofType: CatalogPlaylist.self) { playlist, error in
            completion?(playlist, error)
        }*/
    }
    
    /// Get an item of type T from the Apple Music Catalog by its id
    public func catalogItem<T: Decodable & CatalogQueryable>(forId id: String, ofType type: T.Type, completion: DataCompletion<T>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: CatalogRouter.getCatalogResource(type: type, id: id, storefront: self.storeFront), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: type) { result in
            completion?(result)
            /*switch result {
            case .success(let response):
                completion?(response?.data?.first, nil)
            case .failure(let error):
                completion?(nil, error)
            }*/
        }
    }
    
    /// Pass in an array of ids and their type, and  get the  catalog items.
    public func catalogItems<T: Decodable & CatalogQueryable>(forIds ids: [String], ofType type: T.Type, completion: DataCompletion<T>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: CatalogRouter.getMultipleCatalogResources(type: type, ids: ids, storefront: self.storeFront), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: type) { (result) in
            completion?(result)
            /*switch result {
            case .success(let response):
                completion?(response?.data, nil)
            case .failure(let error):
                completion?(nil, error)
            }*/
        }
    }
    
    /// Get the Apple Music catalog charts. Valid values for the types parameter  are songs, playlists, and albums
    public func charts(types: [IncludeParameter], storeFront: String, limit: Int, completion: DataCompletion<ChartResponse>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: CatalogRouter.charts(types: types, limit: limit, storefront: storeFront), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: ChartResponse.self) { result in
            completion?(result)
            /*switch result {
            case .success(let response):
                completion?(response?.results, nil)
            case .failure(let error):
                completion?(nil, error)
            }*/
        }
    }
    
    public func chartsForGenre(genre: AppleMusicGenre, types: [IncludeParameter], limit: Int, completion: DataCompletion<ChartResponse>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: CatalogRouter.chartsForGenre(genre: genre, types: types, limit: limit, storefront: storeFront), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: ChartResponse.self) { result in
            completion?(result)
            /*switch result {
            
            case .success(let response):
                completion?(response?.results, nil)
            case .failure(let error):
                completion?(nil, error)
            }*/
        }
    }
    
}

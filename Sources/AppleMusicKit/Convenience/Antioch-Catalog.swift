import Foundation

extension Antioch {
    
    /// Get an item of type T from the Apple Music Catalog by its id
    public func catalogItem<T: Decodable & CatalogQueryable>(forId id: String, ofType type: T.Type, completion: DataCompletion<T>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: CatalogRouter.getCatalogResource(type: type, id: id, storefront: self.storeFront), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: type, completion: completion)
    }
    
    /// Pass in an array of ids and their type, and  get the  catalog items.
    public func catalogItems<T: Decodable & CatalogQueryable>(forIds ids: [String], ofType type: T.Type, completion: DataCompletion<T>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: CatalogRouter.getMultipleCatalogResources(type: type, ids: ids, storefront: self.storeFront), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: type, completion: completion)
    }
    
    /// Get the Apple Music catalog charts. Valid values for the types parameter  are songs, playlists, and albums
    public func charts(types: [IncludeParameter], storeFront: String, limit: Int, completion: DataCompletion<ChartResponse>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: CatalogRouter.charts(types: types, limit: limit, storefront: storeFront), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: ChartResponse.self, completion: completion)
    }
    
    public func chartsForGenre(genre: AppleMusicGenre, types: [IncludeParameter], limit: Int, completion: DataCompletion<ChartResponse>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: CatalogRouter.chartsForGenre(genre: genre, types: types, limit: limit, storefront: storeFront), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: ChartResponse.self, completion: completion)
    }
}

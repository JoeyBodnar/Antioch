import Foundation

extension Antioch {
    
    /// search the Apple Music catalog
    public func searchCatalog(forTerm term: String, includingTypes types: [IncludeParameter], withLimit limit: Int, andOffset offset: Int, completion: DataCompletion<CatalogSearchResults>) {
        let endpoint: SearchRouter = SearchRouter.searchCatalog(searchTerm: term, types: types, limit: limit, offset: offset, storefront: self.storeFront)
        let builder: RequestBuilder = RequestBuilder(endPoint: endpoint, method: .get)
        performRequest(request: builder.urlRequest, forResponseType: CatalogSearchResults.self, completion: completion)
    }
    
    /// search the user's library
    public func searchLibrary(forTerm term: String, includingTypes types: [IncludeParameter.Library], withLimit limit: Int, andOffset offset: Int, completion: DataCompletion<LibrarySearchResults>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: SearchRouter.searchLibrary(searchTerm: term, types: types, linit: limit, offset: offset), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: LibrarySearchResults.self, completion: completion)
    }
    
    public func searchHints(forTerm term: String, completion: DataCompletion<SearchHints>) {
        let endpoint: SearchRouter = SearchRouter.searchHints(searchTerm: term, storefront: self.storeFront)
        let builder: RequestBuilder = RequestBuilder(endPoint: endpoint, method: .get)
        performRequest(request: builder.urlRequest, forResponseType: SearchHints.self, completion: completion)
    }
}

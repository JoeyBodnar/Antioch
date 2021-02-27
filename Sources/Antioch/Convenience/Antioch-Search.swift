import Foundation

extension Antioch {
    
    /// search the Apple Music catalog
    public func searchCatalog(forTerm term: String, includingTypes types: [IncludeParameter], withLimit limit: Int, andOffset offset: Int, completion: DataCompletion<CatalogSearchResults>) {
        let endpoint: SearchRouter = SearchRouter.searchCatalog(searchTerm: term, types: types, limit: limit, offset: offset, storefront: self.storeFront)
        let request = AntiochRequest(endPoint: endpoint, method: .get)
        performRequest(request: request, forResponseType: CatalogSearchResults.self) { result in
            switch result {
            case .success(let response):
                completion?(response?.results, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    /// search the user's library
    public func searchLibrary(forTerm term: String, includingTypes types: [IncludeParameter.Library], withLimit limit: Int, andOffset offset: Int, completion: DataCompletion<LibrarySearchResults>) {
        let request = AntiochRequest(endPoint: SearchRouter.searchLibrary(searchTerm: term, types: types, linit: limit, offset: offset), method: .get)
        performRequest(request: request, forResponseType: LibrarySearchResults.self) { result in
            switch result {
            case .success(let response):
                completion?(response?.results, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    public func searchHints(forTerm term: String, completion: DataCompletion<[String]>) {
        let endpoint: SearchRouter = SearchRouter.searchHints(searchTerm: term, storefront: self.storeFront)
        let request = AntiochRequest(endPoint: endpoint, method: .get)
        performRequest(request: request, forResponseType: SearchHints.self) { result in
            switch result {
            case .success(let response):
                let terms = response?.results?.terms ?? []
                completion?(terms, nil)
            case .failure(let error):
                completion?([], error)
            }
        }
    }
    
}

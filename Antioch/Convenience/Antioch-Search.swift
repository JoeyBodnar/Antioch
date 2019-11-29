//
//  APIManagerSearch.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/25/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

extension Antioch {
    
    public func searchCatalog(forTerm term: String, includingTypes types: [IncludeParameter], withLimit limit: Int, andOffset offset: Int, completion: DataCompletion<CatalogSearchResults>) {
        let request = AntiochRequest(endPoint: SearchRouter.searchCatalog(term, types, limit, offset), method: .get)
        performRequest(request: request, forResponseType: CatalogSearchResults.self) { result in
            switch result {
            case .success(let response):
                completion?(response?.results, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    public func searchLibrary(forTerm term: String, includingTypes types: [IncludeParameter.Library], withLimit limit: Int, andOffset offset: Int, completion: DataCompletion<LibrarySearchResults>) {
        let request = AntiochRequest(endPoint: SearchRouter.searchLibrary(term, types, limit, offset), method: .get)
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
        let request = AntiochRequest(endPoint: SearchRouter.searchHints(term), method: .get)
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

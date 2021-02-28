//
//  AppleMusicRatiingRouter.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/19/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public enum SearchRouter: Provider {
    
    /// String is search term, [IncludeParameter] is the types you want to search for, first Int is limit, last is offset
    case searchCatalog(searchTerm: String, types: [IncludeParameter], limit: Int, offset: Int, storefront: String)
    
    /// String is search term, [IncludeParameter] is the types you want to search for, first Int is limit, last is offset
    case searchLibrary(searchTerm: String, types: [IncludeParameter.Library], linit: Int, offset: Int)
    case searchHints(searchTerm: String, storefront: String)
    
    public var path: String {
        switch self {
        case .searchCatalog(let searchTerm, let types, let limit, let offset, let storefront):
            let allTypes = types.asString()
            let formattedTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
            return "\(baseURL)/catalog/\(storefront)/search?term=\(formattedTerm)&limit=\(limit)&offset=\(offset)&types=\(allTypes)"
        case .searchLibrary(let searchTerm, let types, let limit, let offset):
            let allTypes = types.asString()
            let formattedTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
            return "\(baseURL)/me/library/search?term=\(formattedTerm)&limit=\(limit)&offset=\(offset)&types=\(allTypes)"
        case .searchHints(let searchTerm, let storefront):
            return "\(baseURL)/catalog/\(storefront)/search/hints?term=\(searchTerm)&limit=10"
        }
    }
    
    internal var baseURL: String {
        return "\(RoutingConstants.appleMusicBaseURL)"
    }
}

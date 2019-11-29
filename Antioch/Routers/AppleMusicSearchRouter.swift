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
    case searchCatalog(String, [IncludeParameter], Int, Int)
    
    /// String is search term, [IncludeParameter] is the types you want to search for, first Int is limit, last is offset
    case searchLibrary(String, [IncludeParameter.Library], Int, Int)
    case searchHints(String)
    
    public var path: String {
        switch self {
        case .searchCatalog(let searchTerm, let types, let limit, let offset):
            let allTypes = types.asString()
            let formattedTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
            return "\(baseURL)/catalog/\(Antioch.shared.storeFront)/search?term=\(formattedTerm)&limit=\(limit)&offset=\(offset)&types=\(allTypes)"
        case .searchLibrary(let searchTerm, let types, let limit, let offset):
            let allTypes = types.asString()
            let formattedTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
            return "\(baseURL)/me/library/search?term=\(formattedTerm)&limit=\(limit)&offset=\(offset)&types=\(allTypes)"
        case .searchHints(let searchTerm):
            return "\(baseURL)/catalog/\(Antioch.shared.storeFront)/search/hints?term=\(searchTerm)&limit=10"
        }
    }
    
    internal var baseURL: String {
        return "\(RoutingConstants.appleMusicBaseURL)"
    }
}

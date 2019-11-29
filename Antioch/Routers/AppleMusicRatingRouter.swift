//
//  AppleMusicRouter.swift
//  Siam
//
//  Created by Stephen Bodnar on 8/19/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public enum RatingRouter: Provider {
    
    case rate(Rateable) // item type is songs, albums, etc. String is id of item
    case rateWithId(AppleMusicItemType, String) // string is item id
    case multipleRatings(AppleMusicItemType, [String])
    
    public var path: String {
        switch self {
        case .rate(let item):
            return "\(baseURL)\(rateablePath(for: item.type))/\(item.id)"
        case .rateWithId(let type, let id):
            return "\(baseURL)\(rateablePath(for: type))/\(id)"
        case .multipleRatings(let type, let ids):
            let idsJoined = ids.joined(separator: ",")
            print("url is \(baseURL)\(rateablePath(for: type))?ids=\(idsJoined)")
            return "\(baseURL)\(rateablePath(for: type))?ids=\(idsJoined)"
        }
    }
    
    internal var baseURL: String {
        return "\(RoutingConstants.appleMusicBaseURL)/me/ratings/"
    }
    
    // the Apple Music API does not support rating library albums at this time
    fileprivate func rateablePath(for type: AppleMusicItemType) -> String {
        return type.rawValue
    }
}

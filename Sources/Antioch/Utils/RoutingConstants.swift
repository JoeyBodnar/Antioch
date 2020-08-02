//
//  Constants.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/22/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

struct RoutingConstants {
    fileprivate static let version = "v1"
    fileprivate static let scheme = "https"
    fileprivate static let base = "api.music.apple.com/"
    
    static let appleMusicBaseURL = "\(RoutingConstants.scheme)://\(RoutingConstants.base)\(RoutingConstants.version)"
}


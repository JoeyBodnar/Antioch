//
//  NetworkingConstants.swift
//  Siam
//
//  Created by Stephen Bodnar on 12/31/18.
//  Copyright © 2018 Stephen Bodnar. All rights reserved.
//

import Foundation

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case musicUserToken = "Music-User-Token"
    case contentType = "Content-Type"
    case contentLength = "Content-Length"
    case userAgent = "User-Agent"
}

enum HTTPContentType: String {
    case json = "application/json"
}


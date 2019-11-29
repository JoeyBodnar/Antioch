//
//  ResponseRoot.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/20/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

// https://developer.apple.com/documentation/applemusicapi/responseroot
/// The JSON root found in every response
public final class ResponseRoot<T: Decodable>: Decodable {
    public let data: [T]?
    public let errors: [AppleMusicError]?
    public let href: String?
    
    public let next: String?
    public let results: T?
}

public final class VoidResponse: Decodable {
    public let success: Bool
}

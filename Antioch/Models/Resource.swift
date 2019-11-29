//
//  Resource.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/20/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public class AppleMusicResource<T: Decodable, U: Decodable>: Decodable {
    public var attributes: T?
    public var href: String?
    public let id: String
    public var relationships: U?
    public let type: AppleMusicItemType
    
    public init(id: String, type: AppleMusicItemType) {
        self.id = id
        self.type = type
    }
}

//
//  AppleMusicError.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/20/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

// https://developer.apple.com/documentation/applemusicapi/error
public class AppleMusicError: Decodable, Error {
    public let id: String
    public let code: String
    public let status: String
    public let title: String
    public let detail: String?
}

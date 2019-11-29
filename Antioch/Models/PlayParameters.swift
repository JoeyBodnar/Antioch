//
//  PlayParameters.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/20/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public class PlayParameters: Decodable {
    public let id: String
    public let kind: String
    public let isLibrary: Bool?
    public let globalId: String?
}

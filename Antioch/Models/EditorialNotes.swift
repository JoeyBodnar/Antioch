//
//  EditorialNotes.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/20/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

// https://developer.apple.com/documentation/applemusicapi/editorialnotes
import Foundation

public class EditorialNotes: Decodable {
    public let short: String?
    public let standard: String?
}


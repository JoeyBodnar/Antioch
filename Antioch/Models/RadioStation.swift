//
//  RadioStation.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/22/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public final class RadioStation: AppleMusicResource<RadioStationAttributes, NilRelationship> {
    
    public override init(id: String, type: AppleMusicItemType) {
        super.init(id: id, type: .stations)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

extension RadioStation: CatalogQueryable { }

extension RadioStation: Rateable { }

public final class RadioStationAttributes: Decodable {
    public var artwork: Artwork?
    public var editorialNotes: EditorialNotes?
    public let isLive: Bool
    public let name: String
    public let playParams: PlayParameters
    public let url: String
}

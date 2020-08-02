//
//  Rating.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/22/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public final class Rating: AppleMusicResource<RatingAttributes, NilRelationship> {
    
    public enum State: Int {
        case love = 1
        case dislike = -1
    }
    
    public var likedState: ItemLikedState {
        guard let value = attributes?.value else {
            return .neitherLovedNorDisliked
        }
        
        return value == 1 ? .loved : value == -1 ? .disliked : .neitherLovedNorDisliked
    }
    
    public override init(id: String, type: AppleMusicItemType) {
        super.init(id: id, type: .ratings)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

public final class RatingAttributes: Decodable {
    var value: Int
}

public enum ItemLikedState {
    case loved
    case disliked
    case neitherLovedNorDisliked
    
    // used for local songs. apple music songs use 1/-1
    public var number: Int {
        switch self {
        case .loved: return 2
        case .disliked: return 3
        case .neitherLovedNorDisliked: return 0
        }
    }
    
    public var appleMusicNumber: Int {
        switch self {
        case .loved: return 1
        case .disliked: return -1
        case .neitherLovedNorDisliked: return 0
        }
    }
    
    public var text: String {
        switch self {
        case .loved: return "songLiked"
        case .disliked: return "songDisliked"
        case .neitherLovedNorDisliked: return "neitherLovedNorDisliked"
        }
    }
    
    public var publicActionText: String {
        switch self {
        case .loved: return "Love"
        case .disliked: return "Dislike"
        case .neitherLovedNorDisliked: return ""
        }
    }
}

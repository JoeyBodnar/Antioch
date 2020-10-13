import Foundation

public final class Curator: AppleMusicResource<CuratorAttributes, NilRelationship> {
    
}

public final class CuratorAttributes: Decodable {
    public var artwork: Artwork?
    public var editorialNotes: EditorialNotes?
    public let name: String?
    public let url: String?
}



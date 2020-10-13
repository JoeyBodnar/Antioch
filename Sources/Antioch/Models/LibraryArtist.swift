import Foundation

public final class LibraryArtist: AppleMusicResource<LibraryArtistAttributes, NilRelationship> {
    public override init(id: String, type: AppleMusicItemType) {
        super.init(id: id, type: .libraryArtists)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

public final class LibraryArtistAttributes: Decodable {
    public let name: String
}


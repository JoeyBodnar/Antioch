import Foundation

public final class CatalogArtist: AppleMusicResource<CatalogArtistAttributes, CatalogArtistRelationships> {
    
    public override init(id: String, type: AppleMusicItemType) {
        super.init(id: id, type: .artists)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
}

extension CatalogArtist: CatalogQueryable { }

public final class CatalogArtistAttributes: Decodable {
    public let genreNames: [String]
    public let name: String
    public let url: String
}

public final class CatalogArtistRelationships: Decodable {
    public let albums: Relationship<CatalogAlbum>
}

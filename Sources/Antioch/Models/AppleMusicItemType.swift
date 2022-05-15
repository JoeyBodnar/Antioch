import Foundation

public enum IncludeParameter: String {
    case songs = "songs"
    case artists = "artists"
    case albums = "albums"
    case playlists = "playlists"
    case stations = "stations"
    
    public enum Library: String {
        case librarySongs = "library-songs"
        case libraryPlaylists = "library-playlists"
        case libraryAlbums = "library-albums"
        case libraryArtists = "library-artists"
    }
}

extension Array where Element == IncludeParameter {
    public func asString() -> String {
        return self.map { $0.rawValue }.joined(separator: ",")
    }
}

extension Array where Element == IncludeParameter.Library {
    public func asString() -> String {
        return self.map { $0.rawValue }.joined(separator: ",")
    }
}

public struct AddableItem {
    public let type: AppleMusicItemType
    public let ids: [String]
    
    public init(type: AppleMusicItemType, ids: [String]) {
        self.type = type
        self.ids = ids
    }
}

public enum AppleMusicItemType: String, Codable {
    case songs = "songs"
    case artists = "artists"
    case albums = "albums"
    case playlists = "playlists"
    case stations = "stations"
    case ratings = "ratings"
    case genres = "genres"
    case curators = "curators"
    case appleCurators = "apple-curators"
    
    case personalRecommendation = "personal-recommendation"
    
    case librarySongs = "library-songs"
    case libraryArtists = "library-artists"
    case libraryAlbums = "library-albums"
    case libraryPlaylists = "library-playlists"
    
    case socialProfiles = "social-profiles"
    
    public enum Library: String {
        case songs = "songs"
        case albums = "albums"
        case playlists = "playlists"
        case artists = "artists"
    }
}

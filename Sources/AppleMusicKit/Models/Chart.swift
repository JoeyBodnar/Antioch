import Foundation

public final class Chart<T: Decodable>: Decodable {
    public let name: String
    public let chart: String
    public var data: [T] // could be an array of songs, albums, or playlists
}

public final class ChartResponse: Decodable {
    public let playlists: [Chart<CatalogPlaylist>]?
    public let albums: [Chart<CatalogAlbum>]?
    public let songs: [Chart<CatalogSong>]?
}

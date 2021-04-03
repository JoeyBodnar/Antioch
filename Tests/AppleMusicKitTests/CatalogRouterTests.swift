import XCTest
@testable import AppleMusicKit

final class CatalogRouterTests: XCTestCase {
    
    func testGetCatalogSongEndpoint() {
        let songEndpoint: String = CatalogRouter.getCatalogResource(type: CatalogSong.self, id: "123456", storefront: "de").path
        XCTAssertEqual(songEndpoint, "https://api.music.apple.com/v1/catalog/de/songs/123456")
        
        let playlistEndpoint: String = CatalogRouter.getCatalogResource(type: CatalogPlaylist.self, id: "123456", storefront: "de").path
        XCTAssertEqual(playlistEndpoint, "https://api.music.apple.com/v1/catalog/de/playlists/123456")
        
        let albumEndpoint: String = CatalogRouter.getCatalogResource(type: CatalogAlbum.self, id: "123456", storefront: "de").path
        XCTAssertEqual(albumEndpoint, "https://api.music.apple.com/v1/catalog/de/albums/123456")
    }
    
    func testGetMultipleCatalogResourcesEndpoint() {
        let songsEndpoint: String = CatalogRouter.getMultipleCatalogResources(type: CatalogSong.self, ids: ["1", "123", "432", "765"], storefront: "tw").path
        XCTAssertEqual(songsEndpoint, "https://api.music.apple.com/v1/catalog/tw/songs?ids=1,123,432,765")
        
        let playlistsEndpoint: String = CatalogRouter.getMultipleCatalogResources(type: CatalogPlaylist.self, ids: ["1", "123", "432", "765"], storefront: "tw").path
        XCTAssertEqual(playlistsEndpoint, "https://api.music.apple.com/v1/catalog/tw/playlists?ids=1,123,432,765")
        
        let albumsEndpoint: String = CatalogRouter.getMultipleCatalogResources(type: CatalogAlbum.self, ids: ["1", "123", "432", "765"], storefront: "tw").path
        XCTAssertEqual(albumsEndpoint, "https://api.music.apple.com/v1/catalog/tw/albums?ids=1,123,432,765")
    }
    
    func testGetChartsEndpoint() {
        let chartsEndpoint: String = CatalogRouter.charts(types: [.albums, .playlists, .songs, .stations], limit: 7, storefront: "tw").path
        XCTAssertEqual(chartsEndpoint, "https://api.music.apple.com/v1/catalog/tw/charts?types=albums,playlists,songs,stations&limit=7")
    }
    
    func testChartsForGenreEndpoint() {
        let chartsForGenre: String = CatalogRouter.chartsForGenre(genre: AppleMusicGenre.allGenres[1], types: [.albums, .playlists, .songs], limit: 9, storefront: "tw").path
        XCTAssertEqual(chartsForGenre, "https://api.music.apple.com/v1/catalog/tw/charts?types=albums,playlists,songs&genre=20&limit=9")
    }
}

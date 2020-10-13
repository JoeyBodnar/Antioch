import XCTest
@testable import Antioch

final class CatalogRouterTests: XCTestCase {
    
    func testGetCatalogSong() {
        // https://developer.apple.com/documentation/applemusicapi/get_a_catalog_song
        let getCatalogResource = CatalogRouter.getCatalogResource(CatalogSong.self, "000000")
        XCTAssertTrue(getCatalogResource.path == "https://api.music.apple.com/v1/catalog/us/songs/000000")
    }
    
    func testGetCatalogSongs() {
        // https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_songs_by_id
        let getCatalogResource = CatalogRouter.getMultipleCatalogResources(CatalogSong.self, ["000000", "111111", "222222"])
        let expectedPath = "https://api.music.apple.com/v1/catalog/us/songs?ids=000000,111111,222222"
        XCTAssertTrue(getCatalogResource.path == expectedPath)
    }
    
    func testGetCatalogPlaylist() {
        // https://developer.apple.com/documentation/applemusicapi/get_a_catalog_song
        let getCatalogResource = CatalogRouter.getCatalogResource(CatalogPlaylist.self, "000000")
        XCTAssertTrue(getCatalogResource.path == "https://api.music.apple.com/v1/catalog/us/playlists/000000")
    }
    
    func testGetCatalogPlaylists() {
        // https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_songs_by_id
        let getCatalogResource = CatalogRouter.getMultipleCatalogResources(CatalogPlaylist.self, ["000000", "111111", "222222"])
        let expectedPath = "https://api.music.apple.com/v1/catalog/us/playlists?ids=000000,111111,222222"
        XCTAssertTrue(getCatalogResource.path == expectedPath)
    }
}

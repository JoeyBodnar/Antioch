import XCTest
@testable import Antioch

final class LibraryRouterTests: XCTestCase {
    
    func testGetLibraryResourcePath() {
        //https://developer.apple.com/documentation/applemusicapi/get_a_library_song
        let endpoint = LibraryRouter.getLibraryResource(LibrarySong.self, "0000000")
        XCTAssertTrue(endpoint.path == "https://api.music.apple.com/v1/me/library/songs/0000000")
        
        let endpoint2 = LibraryRouter.getLibraryResource(LibraryPlaylist.self, "0000000")
        XCTAssertTrue(endpoint2.path == "https://api.music.apple.com/v1/me/library/playlists/0000000")
    }
    
    func testGetMultipleLibraryResourcesPath() {
        let endpoint = LibraryRouter.getMultipleLibraryResources(LibrarySong.self, ["000000", "111111", "222222"])
        XCTAssertTrue(endpoint.path == "https://api.music.apple.com/v1/me/library/songs?ids=000000,111111,222222")
        
        let endpoint2 = LibraryRouter.getMultipleLibraryResources(LibraryPlaylist.self, ["000000", "111111", "222222"])
        XCTAssertTrue(endpoint2.path == "https://api.music.apple.com/v1/me/library/playlists?ids=000000,111111,222222")
    }
    
    //https://developer.apple.com/documentation/applemusicapi/add_a_resource_to_a_library
    func testPathForAddItem() {
        let addableItems1 = AddableItem(type: AppleMusicItemType.songs, ids: ["111", "222"])
        
        let endpoint1 = LibraryRouter.addItemsToLibrary([addableItems1])
        let path1 = endpoint1.pathForAddItem(withItems: [addableItems1])
        
        XCTAssertTrue(path1 == "ids[songs]=111,222")
        
        let addableItems2 = AddableItem(type: AppleMusicItemType.albums, ids: ["333", "444"])
        
        let endpoint2 = LibraryRouter.addItemsToLibrary([addableItems1, addableItems2])
        let path2 = endpoint2.pathForAddItem(withItems: [addableItems1, addableItems2])
        
        XCTAssertTrue(path2 == "ids[songs]=111,222&ids[albums]=333,444")
    }
}

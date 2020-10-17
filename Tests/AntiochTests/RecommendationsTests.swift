import XCTest
import Foundation
@testable import Antioch

final class RecommendationsTests: XCTestCase {
    
    func testGetPlaylistCollections() {
        let sourceFile = URL(fileURLWithPath: #file)
        let currentDirectory = sourceFile.deletingLastPathComponent()
        let url = currentDirectory.appendingPathComponent("recommendations.json")
        
        do {
            let data = try Data(contentsOf: url)
            let responseRoot = try JSONDecoder().decode(ResponseRoot<Recommendation>.self, from: data)
            
            let firstObject = try XCTUnwrap(responseRoot.data?[0])
            let firstCollection = firstObject.collections(ofType: CatalogPlaylist.self)
            XCTAssertTrue(firstCollection.count == 4, "collections.count wrong for firstCollection, result was \(firstCollection.count)")
            
            let secondObject = try XCTUnwrap(responseRoot.data?[1])
            let secondCollection = secondObject.collections(ofType: CatalogPlaylist.self)
            XCTAssertTrue(secondCollection.count == 1, "collections.count wrong for secondCollection, result was \(secondCollection.count)")
            
            let secondObjectAlbums = try XCTUnwrap(responseRoot.data?[1])
            let secondCollectionAlbums = secondObjectAlbums.collections(ofType: CatalogAlbum.self)
            XCTAssertTrue(secondCollectionAlbums.count == 11, "collections.count wrong for secondCollectionAlbums, result was \(secondCollectionAlbums.count)")
        } catch let error {
            XCTAssertTrue(false, "No resource URL for recommendations.json. error: \(error)")
        }
    }
    
    func testArrayRecommendationsExtension() {
        let sourceFile = URL(fileURLWithPath: #file)
        let currentDirectory = sourceFile.deletingLastPathComponent()
        let url = currentDirectory.appendingPathComponent("recommendations.json")
        
        do {
            let data = try Data(contentsOf: url)
            let responseRoot = try JSONDecoder().decode(ResponseRoot<Recommendation>.self, from: data)
            
            let recommendations = try XCTUnwrap(responseRoot.data)
            
            let playlistCount = recommendations.collections(ofType: CatalogPlaylist.self).count
            XCTAssertTrue(playlistCount == 62, "playlistCount incorrect, should be \(playlistCount)")
            
            let albumCount = recommendations.collections(ofType: CatalogAlbum.self).count
            XCTAssertTrue(albumCount == 62, "playlistCount incorrect, should be \(albumCount)")
        } catch let error {
            XCTAssertTrue(false, "No resource URL for recommendations.json. error: \(error)")
        }
    }
}


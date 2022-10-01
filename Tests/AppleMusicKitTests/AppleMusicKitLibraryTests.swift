//
//  AppleMusicKitLibraryTests.swift
//  AppleMusicKitTests
//
//  Created by Stephen Bodnar on 9/24/22.
//

import XCTest
@testable import AppleMusicKit

final class AppleMusicKitLibraryTests: XCTestCase {
    
    func testIt() {
        let appleMusicKit = AppleMusicKit()
        appleMusicKit.recentTracks(types: [.songs, .librarySongs], limit: 30, offset: 0) { result in
            
        }
    }
}

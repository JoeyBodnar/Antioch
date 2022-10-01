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
        //appleMusicKit.recentTracks(types: [.songs, .librarySongs], limit: 30, offset: 0) { result in
            
       // }
        
        appleMusicKit.recommendations { result in
            switch result {
            case .success(let recommendationResponseRoot):
                print("test:: \(recommendationResponseRoot)")
            case .failure:
                print("test:: eriughert")
            }
        }
        
        sleep(10)
    }
}

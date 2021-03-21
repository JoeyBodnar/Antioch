//
//  AppleMusicKitTests.swift
//  AppleMusicKitTests
//
//  Created by Stephen Bodnar on 3/21/21.
//

import XCTest
@testable import AppleMusicKit

final class AppleMusicKitTests: XCTestCase {
    
    func testConfigure() {
        let amKit = AppleMusicKit(session: MockURLSession(), dispatchQueue: .main)
        
        amKit.configure(storeFront: "de", authenticationHeader: "mock-jwt")
        XCTAssertEqual(amKit.requestInterceptor.authorizationToken, "mock-jwt")
        XCTAssertEqual(amKit.storeFront, "de")
    }
}

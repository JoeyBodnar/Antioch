//
//  RequestBuilderTests.swift
//  AppleMusicKitTests
//
//  Created by Stephen Bodnar on 3/20/21.
//

import XCTest
@testable import AppleMusicKit

final class RequestBuilderTests: XCTestCase {
    
    func testUrlRequestGetWithAuthHeaderAndMusicUserToken() {
        let builder: RequestBuilder = RequestBuilder(endPoint: MockProvider.test, method: .get)
        builder.authHeader = "mock-auth-header"
        builder.musicUserTokenHeader = "mock-jwt"
        
        let urlRequest = builder.urlRequest
        
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://music.apple.com/me")
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Authorization"], "Bearer mock-auth-header")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Music-User-Token"], "mock-jwt")
    }
    
    func testURLRequestPostWithHeaderAndMusicUserToken() {
        let builder: RequestBuilder = RequestBuilder(endPoint: MockProvider.test, method: .post)
        builder.authHeader = "mock-auth-header"
        builder.musicUserTokenHeader = "mock-jwt"
        
        let urlRequest = builder.urlRequest
        
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://music.apple.com/me")
        XCTAssertEqual(urlRequest?.httpMethod, "POST")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Authorization"], "Bearer mock-auth-header")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Music-User-Token"], "mock-jwt")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
    }
    
    func testURLRequestPutWithHeaderAndMusicUserToken() {
        let builder: RequestBuilder = RequestBuilder(endPoint: MockProvider.testPost, method: .put)
        builder.authHeader = "mock-auth-header"
        builder.musicUserTokenHeader = "mock-jwt"
        
        let urlRequest = builder.urlRequest
        
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://music.apple.com/me/post")
        XCTAssertEqual(urlRequest?.httpMethod, "PUT")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Authorization"], "Bearer mock-auth-header")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Music-User-Token"], "mock-jwt")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
    }
}

//
//  File.swift
//  
//
//  Created by Stephen Bodnar on 3/23/21.
//

import XCTest
@testable import AppleMusicKit

final class RequestInterceptorTests: XCTestCase {
    
    private let appleUrl: String = "www.apple.com"
    
    func testInterceptAddsAuthToken() {
        let request: URLRequest = URLRequest(url: URL(string: appleUrl)!)
        
        let interceptor: RequestInterceptor = RequestInterceptor()
        interceptor.authorizationToken = "mock-am-token"
        interceptor.musicUserToken = "mock-jwt-user-token"
        
        let alteredRequest: URLRequest = interceptor.intercept(request: request)
        
        XCTAssertEqual(alteredRequest.allHTTPHeaderFields?["Authorization"], "Bearer mock-am-token")
        
        // only ads this when the path includes `/me`
        XCTAssertNil(alteredRequest.allHTTPHeaderFields?[HTTPHeaderField.musicUserToken.rawValue])
    }
    
    func testInterceptAdsMusicUserTokenOnMePath() {
        let request: URLRequest = URLRequest(url: URL(string: "www.applemusic.com/me")!)
        
        let interceptor: RequestInterceptor = RequestInterceptor()
        interceptor.authorizationToken = "mock-am-token"
        interceptor.musicUserToken = "mock-jwt-user-token"
        
        let alteredRequest: URLRequest = interceptor.intercept(request: request)
        
        XCTAssertEqual(alteredRequest.allHTTPHeaderFields?["Authorization"], "Bearer mock-am-token")
        XCTAssertEqual(alteredRequest.allHTTPHeaderFields?[HTTPHeaderField.musicUserToken.rawValue], "mock-jwt-user-token")
    }
}

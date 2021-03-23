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
    
    func testPerformRequestForVoidResponseMalformedRequest() {
        let amKit: AppleMusicKit = AppleMusicKit(session: MockURLSession(), dispatchQueue: .main)
        
        var malformedRequestInvoked = false
        amKit.performRequestforVoidResponse(request: nil) { (result: Result<Void, AppleMusicKitError>) in
            switch result {
            case .success: break
            case .failure(let error):
                switch error {
                case .malformedRequest: malformedRequestInvoked = true
                default: break
                }
            }
        }
        
        XCTAssertTrue(malformedRequestInvoked)
    }
    
    func testPerformRequestForVoidResponseApiError() {
        let mockSession: MockURLSession = MockURLSession()
        let amKit = AppleMusicKit(session: mockSession, dispatchQueue: .main)
        
        
        mockSession.response = HTTPURLResponse(url: URL(string: "www.apple.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        let mockRequest: URLRequest = URLRequest(url: URL(string: "www.apple.com")!)
        
        let fileUrlString: String? = Bundle.module.path(forResource: "APIError", ofType: "json")
        let fileUrl: URL = URL(fileURLWithPath: fileUrlString!)
        let data: Data = try! Data(contentsOf: fileUrl)
        mockSession.data = data
        
        var amApiError: AppleMusicError! = nil
        amKit.performRequestforVoidResponse(request: mockRequest) { (result: Result<Void, AppleMusicKitError>) in
            switch result {
            case .success: break
            case .failure(let error):
                switch error {
                case .api(let apiError): amApiError = apiError
                default: break
                }
            }
        }
        
        XCTAssertTrue(amApiError?.status == "404")
        XCTAssertTrue(amApiError?.title == "Invalid resource")
    }
    
    func testPerformRequestVoidResponseParsingError() {
        let mockSession: MockURLSession = MockURLSession()
        let amKit = AppleMusicKit(session: mockSession, dispatchQueue: .main)
        
        
        mockSession.response = HTTPURLResponse(url: URL(string: "www.apple.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        let mockRequest: URLRequest = URLRequest(url: URL(string: "www.apple.com")!)
        
        let fileUrlString: String? = Bundle.module.path(forResource: "APIErrorInvalid", ofType: "json")
        let fileUrl: URL = URL(fileURLWithPath: fileUrlString!)
        let data: Data = try! Data(contentsOf: fileUrl)
        mockSession.data = data
        
        var isParsingError: Bool = false
        amKit.performRequestforVoidResponse(request: mockRequest) { (result: Result<Void, AppleMusicKitError>) in
            switch result {
            case .success: break
            case .failure(let error):
                switch error {
                case .parsing: isParsingError = true
                default: break
                }
            }
        }
        
        XCTAssertTrue(isParsingError)
    }
    
    func testPerformRequestVoidResponseOfflineError() {
        let mockSession: MockURLSession = MockURLSession()
        let amKit = AppleMusicKit(session: mockSession, dispatchQueue: .main)
        
        
        mockSession.response = HTTPURLResponse(url: URL(string: "www.apple.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        mockSession.error = NSError(domain: "com.apple.urlsession", code: -1009, userInfo: nil)
        let mockRequest: URLRequest = URLRequest(url: URL(string: "www.apple.com")!)
        
        var isOfflineError: Bool = false
        amKit.performRequestforVoidResponse(request: mockRequest) { (result: Result<Void, AppleMusicKitError>) in
            switch result {
            case .success: break
            case .failure(let error):
                switch error {
                case .offline: isOfflineError = true
                default: break
                }
            }
        }
        
        XCTAssertTrue(isOfflineError)
    }
    
    func testPerformRequestVoidResponseSuccess() {
        let mockSession: MockURLSession = MockURLSession()
        let amKit = AppleMusicKit(session: mockSession, dispatchQueue: .main)
        
        
        mockSession.response = HTTPURLResponse(url: URL(string: "www.apple.com")!, statusCode: 204, httpVersion: nil, headerFields: nil)
        let mockRequest: URLRequest = URLRequest(url: URL(string: "www.apple.com")!)
        
        var successInvoked: Bool = false
        amKit.performRequestforVoidResponse(request: mockRequest) { (result: Result<Void, AppleMusicKitError>) in
            switch result {
            case .success: successInvoked = true
            case .failure: break
            }
        }
        
        XCTAssertTrue(successInvoked)
    }
}

private let errorJSON = """
{
    "id": "1".
    "code": "002",
    "status": 404,
    "title": "Invalid resource",
    "detail": "Resource not found"
}
"""

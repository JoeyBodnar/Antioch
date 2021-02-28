import XCTest
@testable import Antioch

class AntiochTests: XCTestCase {

    func testConfigureSetsStoreFrontAndAuthenticationHeader() {
        let client = Antioch()
        client.configure(storeFront: "us", authenticationHeader: "mock-token-here")
        
        XCTAssertTrue(client.authenticationHeader == "mock-token-here")
        XCTAssertTrue(client.storeFront == "us")
    }
    
    func testPerformRequestVoidResponseSuccess() {
        let mockSession = MockURLSession()
        mockSession.response = HTTPURLResponse(url: URL(string: "https://apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let client = Antioch(session: mockSession, dispatchQueue: .main)
        
        var successInvoked = false
        client.performRequestforVoidResponse(request: AntiochRequest(endPoint: MockProvider.test1, method: .get)) { success, error in
            successInvoked = success
        }
        
        XCTAssertTrue(successInvoked)
    }
    
    func testPerformRequestVoidResponseFailure() {
        let mockSession = MockURLSession()
        mockSession.response = HTTPURLResponse(url: URL(string: "https://apple.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let client = Antioch(session: mockSession, dispatchQueue: .main)
        
        var successInvoked = false
        var failureInvoked = false
        client.performRequestforVoidResponse(request: AntiochRequest(endPoint: MockProvider.test1, method: .get)) { success, error in
            successInvoked = success
            failureInvoked = error != nil
        }
        
        XCTAssertFalse(successInvoked)
        XCTAssertTrue(failureInvoked)
    }
}

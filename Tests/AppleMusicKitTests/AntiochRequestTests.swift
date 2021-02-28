import XCTest
@testable import Antioch

final class AntiochRequestTests: XCTestCase {
    
    func testCreateGetURLRequest() {
        let request = AntiochRequest(endPoint: MockProvider.test, method: .get)
        
        let urlRequest = request.urlRequest!
        
        XCTAssertTrue(urlRequest.url!.absoluteString == "https://music.apple.com/me")
        XCTAssertTrue(urlRequest.httpMethod == "GET")
    }
    
    func testSetsHeaders() {
        let request = AntiochRequest(endPoint: MockProvider.test, method: .get)
        request.authHeader = "mock-auth"
        request.musicUserTokenHeader = "mock-token"
        
        let urlRequest = request.urlRequest!
        
        XCTAssertTrue(urlRequest.allHTTPHeaderFields!["Authorization"] == "Bearer mock-auth")
        XCTAssertTrue(urlRequest.allHTTPHeaderFields!["Music-User-Token"] == "mock-token")
    }
    
    func testCreatesPostRequest() {
        let request = AntiochRequest(endPoint: MockProvider.testPost, method: .post)
        request.params = ["key1": "value1"]
        
        let urlRequest = request.urlRequest!
        
        XCTAssertTrue(urlRequest.url!.absoluteString == "https://music.apple.com/me/post")
        XCTAssertTrue(urlRequest.httpMethod == "POST")
        
        let json = try! JSONSerialization.jsonObject(with: urlRequest.httpBody!, options: .allowFragments) as! NSDictionary
        let value1 = json.value(forKey: "key1") as! String
        XCTAssertTrue(value1 == "value1")
    }
    
    func testAddsJSONContentHeaderForPostRequest() {
        let request = AntiochRequest(endPoint: MockProvider.testPost, method: .post)
        let urlRequest = request.urlRequest!
        
        XCTAssertTrue(urlRequest.allHTTPHeaderFields!["Content-Type"] == "application/json")
    }
}

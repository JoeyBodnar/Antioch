import XCTest
@testable import Antioch

class AntiochTests: XCTestCase {

    func testConfigureSetsStoreFrontAndAuthenticationHeader() {
        let client = Antioch()
        client.configure(storeFront: "us", authenticationHeader: "mock-token-here")
        
        XCTAssertTrue(client.authenticationHeader == "mock-token-here")
        XCTAssertTrue(client.storeFront == "us")
    }
}

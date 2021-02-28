import Foundation
@testable import Antioch

enum MockProvider: Provider {
    
    case test1
    case test
    case testPost
    
    var path: String {
        switch self {
        case .test1: return "/test1"
        case .test: return "\(baseURL)me"
        case .testPost: return "\(baseURL)me/post"
        }
    }
    
    var baseURL: String {
        return "https://music.apple.com/"
    }
}

final class MockURLSession: URLSessionProtocol {
    
    var error: Error?
    var data: Data?
    var response: HTTPURLResponse?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return MockURLSessionDataTask {
            completionHandler(self.data, self.response, self.error)
        }
    }
}

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    let action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    func resume() {
        action()
    }
}

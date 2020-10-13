import Foundation

final class RequestInterceptor {
    
    var authorizationToken: String?
    var musicUserToken: String?
    
    func intercept(request: URLRequest) -> URLRequest {
        var copy = request
        
        if let authorizationToken = self.authorizationToken {
            copy.setValue("Bearer \(authorizationToken)", forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }
        
        let path = copy.url?.path
        let isPersonalizedPath: Bool = path?.contains("me") ?? false
        if let musicUserToken = self.musicUserToken, isPersonalizedPath {
            copy.setValue(musicUserToken, forHTTPHeaderField: HTTPHeaderField.musicUserToken.rawValue)
        }
        
        return copy
    }
}

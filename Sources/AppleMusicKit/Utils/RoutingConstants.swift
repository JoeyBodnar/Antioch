import Foundation

struct RoutingConstants {
    fileprivate static let version = "v1"
    fileprivate static let scheme = "https"
    fileprivate static let base = "api.music.apple.com/"
    
    static let appleMusicBaseURL = "\(RoutingConstants.scheme)://\(RoutingConstants.base)\(RoutingConstants.version)"
}


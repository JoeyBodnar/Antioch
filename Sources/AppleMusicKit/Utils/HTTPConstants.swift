import Foundation

enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case musicUserToken = "Music-User-Token"
    case contentType = "Content-Type"
    case userAgent = "User-Agent"
}

enum HTTPContentType: String {
    case json = "application/json"
}


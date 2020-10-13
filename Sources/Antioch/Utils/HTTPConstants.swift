import Foundation

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case musicUserToken = "Music-User-Token"
    case contentType = "Content-Type"
    case contentLength = "Content-Length"
    case userAgent = "User-Agent"
}

enum HTTPContentType: String {
    case json = "application/json"
}


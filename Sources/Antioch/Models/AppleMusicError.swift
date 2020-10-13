import Foundation

// https://developer.apple.com/documentation/applemusicapi/error
public class AppleMusicError: Decodable, Error {
    public let id: String
    public let code: String
    public let status: String
    public let title: String
    public let detail: String?
}

/// Used for when there is an error, but can't retrieve it from either the data task  or the AppleMusic API
public class UnknownAntiochError: Error {
    public let message: String
    
    init(message: String) {
        self.message = message
    }
}

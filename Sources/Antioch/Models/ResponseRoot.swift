import Foundation

// https://developer.apple.com/documentation/applemusicapi/responseroot
/// The JSON root found in every response
public final class ResponseRoot<T: Decodable>: Decodable {
    public let data: [T]?
    public let errors: [AppleMusicError]?
    public let href: String?
    
    public let next: String?
    public let results: T?
    
    /// for unit testing purposes.
    internal init(data: [T]?) {
        self.data = data
        self.errors = nil
        self.href = nil
        self.next = nil
        self.results = nil
    }
}

public final class VoidResponse: Decodable {
    public let success: Bool
}

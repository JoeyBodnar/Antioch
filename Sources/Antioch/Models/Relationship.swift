import Foundation

// https://developer.apple.com/documentation/applemusicapi/relationship
public class Relationship<T: Decodable>: Decodable {
    public let data: [T]?
    public let href: String?
    public let next: String?
}

/// empty relationship object, used as placeholder for objects that do not have relationships
public class NilRelationship: Decodable { }

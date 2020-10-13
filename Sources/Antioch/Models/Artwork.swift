import Foundation
import CoreGraphics

// https://developer.apple.com/documentation/applemusicapi/artwork
public class Artwork: Decodable {
    public let bgColor: String?
    public let height: Int?
    public let width: Int?
    public let textColor1: String?
    public let textColor2: String?
    public let textColor3: String?
    public let textColor4: String?
    public let url: String
    
    public func url(forSize size: CGSize) -> String {
        let replacingWidth = url.replacingOccurrences(of: "{w}", with: "\(Int(size.width))")
        return replacingWidth.replacingOccurrences(of: "{h}", with: "\(Int(size.height))")
    }
}

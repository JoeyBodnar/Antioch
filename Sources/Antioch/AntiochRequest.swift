import Foundation

class AntiochRequest {
    var method: HTTPMethod
    var endPoint: Provider
    
    var params: [String: Any]?
    var authHeader: String?
    var musicUserTokenHeader: String?
    
    init(endPoint: Provider, method: HTTPMethod) {
        self.endPoint = endPoint
        self.method = method
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: endPoint.path) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if method != .get {
            request.setValue(HTTPContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        }
        do {
            if let postBody = params {
                request.httpBody = try JSONSerialization.data(withJSONObject: postBody, options: JSONSerialization.WritingOptions.prettyPrinted)
            }
            else {
                print("params were nil")
            }
        } catch {
            print("couldnt set http body")
        }
        
        if let auth = authHeader {
            request.setValue("Bearer \(auth)", forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }
        
        if let token = musicUserTokenHeader {
            request.setValue(token, forHTTPHeaderField: HTTPHeaderField.musicUserToken.rawValue)
        }

        return request
    }
}

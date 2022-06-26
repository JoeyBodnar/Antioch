import Foundation

/// The completion to use when expecting a data response (retrieving songs, playlists, rating, albums, etc)
public typealias DataCompletion<T: Decodable> = ((Result<ResponseRoot<T>, AppleMusicKitError>) -> Void)?

/// the completion to use when we dont expect a response body on success, but just a status code (adding items
/// to playlist, adding to library)
public typealias VoidResponseCompletion = ((Result<Void, AppleMusicKitError>) -> Void)?

public enum AppleMusicKitError: Error {
    
    case api(error: AppleMusicError)
    case offline
    case timeout
    case `internal`(error: NSError)
    case parsing(error: Error, json: String?, statusCode: Int)
    case malformedRequest
    case unknown(statusCode: Int)
    
    public var detail: String? {
        switch self {
        case .api(let error): return error.detail
        case .offline: return "Offline"
        case .timeout: return "Timeout"
        case .internal(let error): return "Internal error: \(error.localizedDescription)"
        case .parsing: return "Parsing error"
        case .malformedRequest: return "Malformed request"
        case .unknown(let code): return "Unknown error: status code: \(code)"
        }
    }
}

public class AppleMusicKit {
    
    private let session: URLSessionProtocol
    private let dispatchQueue: DispatchQueue
    
    public init(session: URLSessionProtocol = URLSession.shared, dispatchQueue: DispatchQueue = .main) {
        self.session = session
        self.dispatchQueue = dispatchQueue
    }
    
    public func configure(storeFront: String, authenticationHeader: String) {
        self.storeFront = storeFront
        self.authenticationHeader = authenticationHeader
    }
    
    /// The storefront for user-specific requests. Default is "us"
    private(set) var storeFront = "us"
    
    public var authenticationHeader: String? {
        didSet {
            requestInterceptor.authorizationToken = authenticationHeader
        }
    }
    
    public var musicUserToken: String? {
        didSet {
            requestInterceptor.musicUserToken = musicUserToken
        }
    }
    
    internal var requestInterceptor: RequestInterceptor = RequestInterceptor()
    
    /// Not all responses (such as deleting ratings) will have a response body. For those requests, we handle the response with this method
    func performRequestforVoidResponse(request: URLRequest?, completion: VoidResponseCompletion) {
        guard let urlRequest: URLRequest = request else {
            completion?(.failure(AppleMusicKitError.malformedRequest))
            return
        }
        
        let interceptedRequest = requestInterceptor.intercept(request: urlRequest)
        
        let task = session.dataTask(with: interceptedRequest) { [weak self] (data, response, error) in
            guard let self = self else { return }
            let statusCode: Int = (response as? HTTPURLResponse)?.statusCode ?? 500
            
            self.dispatchQueue.async {
                if let unwrappedError: Error = error {
                    let nsError: NSError = unwrappedError as NSError
                    if nsError.code == -1009 {
                        completion?(.failure(AppleMusicKitError.offline))
                    } else {
                        completion?(.failure(AppleMusicKitError.internal(error: nsError)))
                    }
                } else if statusCode >= 400 {
                    if let unwrappedData: Data = data {
                        do {
                            let decoder: JSONDecoder = JSONDecoder()
                            let apiError: AppleMusicError = try decoder.decode(AppleMusicError.self, from: unwrappedData)
                            completion?(.failure(AppleMusicKitError.api(error: apiError)))
                        } catch let parsingError {
                            let jsonString: String? = String(data: unwrappedData, encoding: .utf8)
                            completion?(.failure(AppleMusicKitError.parsing(error: parsingError, json: jsonString, statusCode: statusCode)))
                        }
                    } else {
                        completion?(.failure(AppleMusicKitError.unknown(statusCode: statusCode)))
                    }
                } else {
                    completion?(.success(()))
                }
            }
        }
        
        task.resume()
    }
     
    // for requests where we are expecting a JSON response body
    func performRequest<T>(request: URLRequest?, forResponseType type: T.Type, completion: ((Result<ResponseRoot<T>, AppleMusicKitError>) -> Void)? ) {
        guard let urlRequest: URLRequest = request else {
            completion?(.failure(AppleMusicKitError.malformedRequest))
            return
        }
        
        let interceptedRequest: URLRequest = requestInterceptor.intercept(request: urlRequest)
        
        let task = session.dataTask(with: interceptedRequest) { [weak self] (data, response, error) in
            guard let self = self else { return }
            let statusCode: Int = (response as? HTTPURLResponse)?.statusCode ?? 500
            
            self.dispatchQueue.async {
                if let unwrappedError: Error = error {
                    let nsError: NSError = unwrappedError as NSError
                    if nsError.code == -1009 {
                        completion?(.failure(AppleMusicKitError.offline))
                    } else {
                        completion?(.failure(AppleMusicKitError.internal(error: nsError)))
                    }
                } else if let unwrappedData: Data = data {
                    let decoder: JSONDecoder = JSONDecoder()
                    
                    do {
                        if statusCode >= 400 { // attempt to parse error
                            let apiError: AppleMusicError = try decoder.decode(AppleMusicError.self, from: unwrappedData)
                            completion?(.failure(AppleMusicKitError.api(error: apiError)))
                        } else {
                            let results: ResponseRoot<T> = try decoder.decode(ResponseRoot<T>.self, from: unwrappedData)
                            completion?(.success(results))
                        }
                    } catch let parsingError { // will run when both failing to parse the error or failing to parse the result. Send statusCode along with to indicate which one
                        let jsonString: String? = String(data: unwrappedData, encoding: .utf8)
                        completion?(.failure(AppleMusicKitError.parsing(error: parsingError, json: jsonString, statusCode: statusCode)))
                    }
                }
            }
        }
        
        task.resume()
    }
}

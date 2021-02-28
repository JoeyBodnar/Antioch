import Foundation

/// The completion to use when expecting a data response (retrieving songs, playlists, rating, albums, etc)
public typealias DataCompletion<T: Decodable> = ((Result<ResponseRoot<T>, Error>) -> Void)?

/// the completion to use when we dont expect a response body on success, but just a status code (adding items
/// to playlist, adding to library)
public typealias VoidResponseCompletion = ((Result<Void, Error>) -> Void)?

public class Antioch {
    
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
        guard let urlRequest = request else {
            return
        }
        let interceptedRequest = requestInterceptor.intercept(request: urlRequest)
        
        let task = session.dataTask(with: interceptedRequest) { (data, response, error) in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
            if statusCode >= 400 {
                do {
                    guard let unwrappedData = data else {
                        let unwrappedError = error ?? UnknownAntiochError(message: "Error retrieving data. Could not retrieve data task error. Status code: \(statusCode)")
                        completion?(.failure(unwrappedError))
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    let error = try decoder.decode(AppleMusicError.self, from: unwrappedData)
                    completion?(.failure(error))
                    //completion?(false, error)
                } catch { }
            } else {
                completion?(.success(()))
            }
        }
        task.resume()
    }
    
    func performRequest<T>(request: URLRequest?, forResponseType type: T.Type, completion: ((Result<ResponseRoot<T>, Error>) -> Void)? ) {
        guard let urlRequest = request else { return }
        
        let interceptedRequest = requestInterceptor.intercept(request: urlRequest)
        
        let task = session.dataTask(with: interceptedRequest) { (data, response, error) in
            do {
                guard let unwrappedData = data else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
                    let unwrappedError = error ?? UnknownAntiochError(message: "Error retrieving data. Could not retrieve data task error. Status code: \(statusCode)")
                    completion?(.failure(unwrappedError))
                    return
                }
                
                let decoder = JSONDecoder()
                let results = try decoder.decode(ResponseRoot<T>.self, from: unwrappedData)

                if let error = results.errors?.first {
                    completion?(.failure(error))
                } else {
                    completion?(.success(results))
                }
            } catch let error {
                print("Antioch error:: error for request \(String(describing: request)), with error: \(error)")
                if let unwrappedData = data, let jsonString = String(data: unwrappedData, encoding: .utf8) {
                    print("json retrieved that failed to parse is: \(jsonString) for url \(String(describing: urlRequest.url?.absoluteString))")
                }
                
                completion?(.failure(error))
            }
        }
        
        task.resume()
    }
}

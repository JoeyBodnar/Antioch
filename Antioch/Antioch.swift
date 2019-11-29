//
//  APIManager.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/19/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

/// The completion to use when expecting a data response (retrieving songs, playlists, rating, albums, etc)
public typealias DataCompletion<T> = ((_ item: T?, _ error: Error?) -> Void)?

/// the completion to use when retrieving an array of items (like multiple stations, songs, etc at once)
public typealias CollectionDataCompletion<T> = ((_ items: [T]?, _ error: Error?) -> Void)?

/// the completion to use when we dont expect a response body on success, but just a status code (adding items
/// to playlist, adding to library)
public typealias VoidResponseCompletion = ((_ success: Bool, _ error: Error?) -> Void)?

public class Antioch {
    
    public static let shared = Antioch()
    
    public func configure(storeFront: String, authenticationHeader: String) {
        self.storeFront = storeFront
        self.authenticationHeader = authenticationHeader
    }
    
    /// The storefront for user-specific requests. Default is "us"
    public var storeFront = ""
    
    public var authenticationHeader: String?
    public var musicUserToken: String?
    
    /// Not all responses (such as deleting ratings) will have a response body. For those requests, we handle the response with this method
    func performRequestforVoidResponse(request: AntiochRequest, completion: VoidResponseCompletion) {
        guard let urlRequest = request.urlRequest else { return }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
            if statusCode >= 400 {
                let decoder = JSONDecoder()
                do {
                    let error = try decoder.decode(AppleMusicError.self, from: data!)
                    completion?(false, error)
                } catch {
                    completion?(false, nil)
                }
            } else  {
                completion?(statusCode <= 204, nil)
            }
        }
        task.resume()
    }
    
    func performRequest<T>(request: AntiochRequest, forResponseType type: T.Type, completion: ((Result<ResponseRoot<T>?, Error>) -> Void)? ) {
        guard let urlRequest = request.urlRequest else { return }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(ResponseRoot<T>.self, from: data!)

                if let error = results.errors?.first {
                    completion?(.failure(error))
                } else {
                    completion?(.success(results))
                }
            } catch let error {
                print("error is \(error)")
                completion?(.failure(error))
            }
        }
        
        task.resume()
    }
}

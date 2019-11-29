//
//  APIManagerRatings.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/25/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

extension Antioch {
    
    public func rate<T: Rateable & Decodable>(item: T, withRating rating: Rating.State, completion: DataCompletion<Rating>) {
        let request = AntiochRequest(endPoint: RatingRouter.rate(item), method: .put)
        request.params = ["type": "rating", "attributes": ["value": rating.rawValue]]
        
        performRequest(request: request, forResponseType: Rating.self) { result in
            print("rating result is \(result)")
            switch result {
            case .success(let response):
                completion?(response?.data?.first, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    public func getRating(for id: String, ofType type: AppleMusicItemType, completion: DataCompletion<Rating>) {
        let request = AntiochRequest(endPoint: RatingRouter.rateWithId(type, id), method: .get)
        performRequest(request: request, forResponseType: Rating.self) { result in
            
            let neitherLikeNorDislikeRating = Rating(id: "0", type: .ratings)
            switch result {
            case .success(let response):
                let rating = response?.data?.first ?? neitherLikeNorDislikeRating
                completion?(rating, nil)
            case .failure(let error):
                completion?(neitherLikeNorDislikeRating, error)
            }
        }
    }
    
    public func getRating<T: Rateable & Decodable>(forItem item: T, completion: DataCompletion<Rating>) {
        let request = AntiochRequest(endPoint: RatingRouter.rate(item), method: .get)
        performRequest(request: request, forResponseType: Rating.self) { result in
            
            let neitherLikeNorDislikeRating = Rating(id: "0", type: .ratings)
            switch result {
            case .success(let response):
                let rating = response?.data?.first ?? neitherLikeNorDislikeRating
                completion?(rating, nil)
            case .failure(let error):
                completion?(neitherLikeNorDislikeRating, error)
            }
        }
    }
    
    public func getMultipleRatings(forType type: AppleMusicItemType, ids: [String], completion: CollectionDataCompletion<Rating>) {
        let request = AntiochRequest(endPoint: RatingRouter.multipleRatings(type, ids), method: .get)
        performRequest(request: request, forResponseType: Rating.self) { result in
            switch result {
            case .success(let response):
                completion?(response?.data, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    public func removeRating<T: Rateable & Decodable>(forItem item: T, completion: VoidResponseCompletion) {
        let request = AntiochRequest(endPoint: RatingRouter.rate(item), method: .delete)
        performRequestforVoidResponse(request: request) { success, error in
            completion?(success, error)
        }
    }
}

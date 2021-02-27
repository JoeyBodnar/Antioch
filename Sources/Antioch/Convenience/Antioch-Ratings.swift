import Foundation

extension Antioch {
    
    /// Rate an item of type T and pass in the rating to assign it
    public func rate<T: Rateable & Decodable>(item: T, withRating rating: Rating.State, completion: DataCompletion<Rating>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: RatingRouter.rate(item), method: .put)
        builder.params = ["type": "rating", "attributes": ["value": rating.rawValue]]
        
        performRequest(request: builder.urlRequest, forResponseType: Rating.self) { result in
            switch result {
            case .success(let response):
                completion?(response?.data?.first, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    /// Get a rating for an object by passing in its id. Valid values for the type parameter are
    /// songs, albums, playlists, stations, library-songs, library-playlists
    public func getRating(for id: String, ofType type: AppleMusicItemType, completion: DataCompletion<Rating>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: RatingRouter.rateWithId(type, id), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: Rating.self) { result in
            
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
    
    /// Get a rating for an item by passing in the item
    public func getRating<T: Rateable & Decodable>(forItem item: T, completion: DataCompletion<Rating>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: RatingRouter.rate(item), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: Rating.self) { result in
            
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
    
    /// Get multiple ratings by passing in the type and the ids for the items whose ratings you want to retrieve
    public func getMultipleRatings(forType type: AppleMusicItemType, ids: [String], completion: CollectionDataCompletion<Rating>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: RatingRouter.multipleRatings(type, ids), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: Rating.self) { result in
            switch result {
            case .success(let response):
                completion?(response?.data, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    /// Remove a rating for an item
    public func removeRating<T: Rateable & Decodable>(forItem item: T, completion: VoidResponseCompletion) {
        let builder: RequestBuilder = RequestBuilder(endPoint: RatingRouter.rate(item), method: .delete)
        performRequestforVoidResponse(request: builder.urlRequest) { success, error in
            completion?(success, error)
        }
    }
}

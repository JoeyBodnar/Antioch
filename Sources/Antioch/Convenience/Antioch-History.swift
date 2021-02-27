import Foundation

extension Antioch {
    
    /// Get the user's last 10 recently played stations
    public func recentStations(completion: CollectionDataCompletion<RadioStation>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: HistoryRouter.recentStations, method: .get)
        performRequest(request: builder.urlRequest, forResponseType: RadioStation.self) { result in
            switch result {
            case .success(let response):
                completion?(response?.data, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
}

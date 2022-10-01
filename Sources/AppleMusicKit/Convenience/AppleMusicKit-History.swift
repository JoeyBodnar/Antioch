import Foundation

extension AppleMusicKit {
    
    /// Get the user's last 10 recently played stations
    public func recentStations(completion: DataCompletion<RadioStation>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: HistoryRouter.recentStations, method: .get)
        performRequest(request: builder.urlRequest, forResponseType: RadioStation.self) { result in
            completion?(result)
        }
    }
    
    public func recentTracks(types: [RecentTrackType], limit: Int, offset: Int, completion: DataCompletion<RecentTrack>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: HistoryRouter.recentTracks(limit: limit, offset: offset, types: types), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: RecentTrack.self) { result in
            switch result {
            case .success(let responseRoot):
                print(responseRoot.data)
            case .failure(let error):
                break
            }
            
        }
    }
}

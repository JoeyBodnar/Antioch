import Foundation

extension AppleMusicKit {
    
    /// Get the songs for a library playlsit by passing in the playlist's id. We need this method because
    /// when you retrieve a library playlist, the API does not pass back the songs with it. So we need to retrieve them separately
    public func songs(forLibraryPlaylistId playlistId: String, withLimit limit: Int, andOffset offset: Int, completion: DataCompletion<LibrarySong>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: LibraryRouter.songsForPlaylist(playlistId, limit, offset), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: LibrarySong.self, completion: completion)
    }
    
    public func librarySongs(ids: [String], completion: DataCompletion<LibrarySong>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: LibraryRouter.getMultipleLibraryResources(LibrarySong.self, ids), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: LibrarySong.self, completion: completion)
    }
    
    /// Add items to your library by passing in an array of AddableItem objects
    public func addToLibrary(items: [AddableItem], completion: VoidResponseCompletion) {
        let builder: RequestBuilder = RequestBuilder(endPoint: LibraryRouter.addItemsToLibrary(items), method: .post)
        performRequestforVoidResponse(request: builder.urlRequest, completion: completion)
    }
    
    /// Add songs to a playlist. Pass in the playlist id and the ids of the songs.
    public func addToPlaylist(itemIds: [String], toPlaylistWithId playlistId: String, completion: VoidResponseCompletion) {
        let builder: RequestBuilder = RequestBuilder(endPoint: LibraryRouter.addItemsToPlaylist(playlistId), method: .post)
        let body = itemIds.map { id -> [String: String] in
            return ["id" : id, "type": "songs"]
        }
        
        builder.params = ["data": body]
        performRequestforVoidResponse(request: builder.urlRequest, completion: completion)
    }
    
    /// Get a library item of type T using its id
    public func libraryItem<T: Decodable & LibraryQueryable>(forId id: String, ofType type: T.Type, completion: DataCompletion<T>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: LibraryRouter.getLibraryResource(type, id), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: type, completion: completion)
    }
    
    public func libraryItems<T: Decodable & LibraryQueryable>(forIds ids: [String], ofType type: T.Type, completion: DataCompletion<T>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: LibraryRouter.getMultipleLibraryResources(type, ids), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: type, completion: completion)
    }
    
    /// Get all library items of type T. Max and default limit is 100.
    public func allLibraryItems<T: Decodable & LibraryQueryable>(ofType type: T.Type, withLimit limit: Int, andOffset offset: Int, completion: DataCompletion<T>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: LibraryRouter.getAllLibrayResources(type, limit, offset), method: .get)
        performRequest(request: builder.urlRequest, forResponseType: type, completion: completion)
    }
    
    /// Get the user's recommendations
    public func recommendations(completion: DataCompletion<Recommendation>) {
        let builder: RequestBuilder = RequestBuilder(endPoint: LibraryRouter.recommendations, method: .get)
        performRequest(request: builder.urlRequest, forResponseType: Recommendation.self, completion: completion)
    }
    
}

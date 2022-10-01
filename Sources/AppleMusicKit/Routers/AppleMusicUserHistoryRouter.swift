//
//  AppleMusicUserHistoryRouter.swift
//  Siam
//
//  Created by Stephen Bodnar on 11/15/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public enum RecentTrackType: String {
    case librarySongs = "library-songs"
    case songs = "songs"
}

public enum HistoryRouter: Provider {
    
    case recentStations
    case recentTracks(limit: Int, offset: Int, types: [RecentTrackType])
    
    public var path: String {
        switch self {
        case .recentStations:
            return "\(baseURL)radio-stations"
        case .recentTracks(let limit, let offset, let types):
            return "\(baseURL)played/tracks?limit=\(limit)&offset=\(offset)&types=\(typesAsStringArray(types: types))"
        }
    }
    
    internal var baseURL: String {
        return "\(RoutingConstants.appleMusicBaseURL)/me/recent/"
    }
    
    func typesAsStringArray(types: [RecentTrackType]) -> String {
        let arrayOfStrings = types.map { $0.rawValue }
        return arrayOfStrings.joined(separator: ",")
    }
}

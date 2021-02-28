//
//  AppleMusicUserHistoryRouter.swift
//  Siam
//
//  Created by Stephen Bodnar on 11/15/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public enum HistoryRouter: Provider {
    
    case recentStations
    
    public var path: String {
        switch self {
        case .recentStations:
            return "\(baseURL)radio-stations"
        }
    }
    
    internal var baseURL: String {
        return "\(RoutingConstants.appleMusicBaseURL)/me/recent/"
    }
}

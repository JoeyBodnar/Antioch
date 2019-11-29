//
//  Antioch-History.swift
//  Siam
//
//  Created by Stephen Bodnar on 11/15/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

extension Antioch {
    
    public func recentStations(completion: CollectionDataCompletion<RadioStation>) {
        let request = AntiochRequest(endPoint: HistoryRouter.recentStations, method: .get)
        performRequest(request: request, forResponseType: RadioStation.self) { result in
            switch result {
            case .success(let response):
                completion?(response?.data, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
}

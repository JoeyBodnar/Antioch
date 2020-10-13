//
//  Protocols.swift
//  Siam
//
//  Created by Stephen Bodnar on 8/19/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

protocol Provider {
    var path: String { get }
    var baseURL: String { get }
}

/// indicates an item can be rated. Not all items (artists and library albums, for example) can be rated
public protocol Rateable {
    var id: String { get }
    var type: AppleMusicItemType { get }
}

public protocol Addable {
    var type: AppleMusicItemType { get }
    var id: String { get }
}

public extension Rateable where Self: Decodable {
    func rate(rating: Rating.State, completion: ((_ success: Bool, _ error: Error?) -> Void)?) {
        Antioch.shared.rate(item: self, withRating: rating) { (rating, error) in
            completion?(rating != nil, error)
        }
    }
    
    func getRating(completion: DataCompletion<Rating>) {
        Antioch.shared.getRating(forItem: self, completion: completion)
    }
}

// Protocols to conform to if an object can be queried in the catalog. Used for type safety, because I dont want the user passing a library resource class to the catalogItem method, or a catalog resource to the libraryItem method
public protocol CatalogQueryable { }
public protocol LibraryQueryable { }

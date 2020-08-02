//
//  SearchResults.swift
//  AppleMusicFrameworkTest
//
//  Created by Stephen Bodnar on 8/22/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public typealias CatalogSearchResults = SearchResults<CatalogAlbum, CatalogArtist, CatalogSong, CatalogPlaylist>
public typealias LibrarySearchResults = SearchResults<LibraryAlbum, LibraryArtist, LibrarySong, LibraryPlaylist>

public final class SearchResults<Albums: Decodable, Artists: Decodable, Songs: Decodable, Playlists: Decodable>: Decodable {
    public var albums: ResponseRoot<Albums>?
    public var artists: ResponseRoot<Artists>?
    public var songs: ResponseRoot<Songs>?
    public var playlists: ResponseRoot<Playlists>?
}

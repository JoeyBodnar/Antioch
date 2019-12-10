//
//  AppleMusicChart.swift
//  Siam
//
//  Created by Stephen Bodnar on 1/30/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//
import Foundation

public class AppleMusicGenre {
    
    public var name: String
    public var id: Int
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    public static var allGenres: [AppleMusicGenre] {
        let all = [AppleMusicGenre(id: 29, name: GenreName.anime), AppleMusicGenre(id: 20, name: GenreName.alternative), AppleMusicGenre(id: 2, name: GenreName.blues), AppleMusicGenre(id: 3, name: GenreName.comedy), AppleMusicGenre(id: 4, name: GenreName.childrens), AppleMusicGenre(id: 5, name: GenreName.classical), AppleMusicGenre(id: 6, name: GenreName.country), AppleMusicGenre(id: 7, name: GenreName.electronic), AppleMusicGenre(id: 19, name: GenreName.world), AppleMusicGenre(id: 18, name: GenreName.hipHopRap), AppleMusicGenre(id: 16, name: GenreName.soundtrack), AppleMusicGenre(id: 10, name: GenreName.singerSongwriter), AppleMusicGenre(id: 14, name: GenreName.pop), AppleMusicGenre(id: 12, name: GenreName.latino), AppleMusicGenre(id: 21, name: GenreName.rock), AppleMusicGenre(id: 24, name: GenreName.reggae), AppleMusicGenre(id: 27, name: GenreName.jPop), AppleMusicGenre(id: 51, name: GenreName.kPop), AppleMusicGenre(id: 0, name: GenreName.all),  AppleMusicGenre(id: 8, name: GenreName.holiday), AppleMusicGenre(id: 11, name: GenreName.jazz), AppleMusicGenre(id: 22, name: GenreName.christian)]
        return all.sorted(by: { (chart1, chart2) -> Bool in
            return chart1.name < chart2.name
        })
    }
}

public struct GenreName {
    public static let anime = "Anime"
    public static let alternative = "Alternative"
    public static let blues = "Blues"
    public static let comedy = "Comedy"
    public static let childrens = "Children's"
    public static let christian = "Christian and Gospel"
    public static let classical = "Classical"
    public static let country = "Country"
    public static let electronic = "Electronic"
    public static let world = "World"
    public static let hipHopRap = "Hip-Hop/Rap"
    public static let soundtrack = "Soundtrack"
    public static let singerSongwriter = "Singer/Songwriter"
    public static let pop = "Pop"
    public static let rock = "Rock"
    public static let reggae = "Reggae"
    public static let jPop = "J-Pop"
    public static let kPop = "K-Pop"
    public static let all = "All"
    public static let latino = "Latino"
    public static let news = "News and Sports"
    public static let holiday = "Holiday"
    public static let jazz = "Jazz"
}


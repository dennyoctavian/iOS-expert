//
//  GameData.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Foundation

public struct Game: Identifiable, Equatable, Codable {
    public let id: Int
    public let name: String
    public let released: Date?
    public let backgroundImageURL: URL?
    public let rating: Double
    public let platforms: [String]
    public let genres: [String]
    public let slug: String
    
    public init(id: Int, name: String, released: Date?, backgroundImageURL: URL?, rating: Double, platforms: [String], genres: [String], slug: String) {
            self.id = id
            self.name = name
            self.released = released
            self.backgroundImageURL = backgroundImageURL
            self.rating = rating
            self.platforms = platforms
            self.genres = genres
            self.slug = slug
        }
}

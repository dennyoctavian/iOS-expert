//
//  GameDetail.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Foundation

public struct GameDetail: Identifiable, Equatable, Codable {
    public let id: Int
    public let name: String
    public let description: String
    public let released: Date?
    public let backgroundImageURL: URL?
    public let rating: Double
    public let platforms: [String]
    public let genres: [String]
    public let websiteURL: URL?
    public let developers: [String]
    public let publishers: [String]
    public var uniqueId: Int { id }
    public let slug: String
    
    public init(id: Int, name: String, description: String, released: Date?, backgroundImageURL: URL?, rating: Double, platforms: [String], genres: [String], websiteURL: URL?, developers: [String], publishers: [String], slug: String) {
            self.id = id
            self.name = name
            self.description = description
            self.released = released
            self.backgroundImageURL = backgroundImageURL
            self.rating = rating
            self.platforms = platforms
            self.genres = genres
            self.websiteURL = websiteURL
            self.developers = developers
            self.publishers = publishers
            self.slug = slug
        }
}

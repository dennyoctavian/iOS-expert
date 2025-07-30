//
//  GameData.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Foundation

struct Game: Identifiable, Equatable, Codable {
    let id: Int
    let name: String
    let released: Date?
    let backgroundImageURL: URL?
    let rating: Double
    let platforms: [String]
    let genres: [String]
    let slug: String
}

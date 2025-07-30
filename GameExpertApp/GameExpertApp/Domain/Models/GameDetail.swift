//
//  GameDetail.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Foundation

struct GameDetail: Identifiable, Equatable, Codable {
    let id: Int
    let name: String
    let description: String
    let released: Date?
    let backgroundImageURL: URL?
    let rating: Double
    let platforms: [String]
    let genres: [String]
    let websiteURL: URL?
    let developers: [String]
    let publishers: [String]
    var uniqueId: Int { id }
    let slug: String
}

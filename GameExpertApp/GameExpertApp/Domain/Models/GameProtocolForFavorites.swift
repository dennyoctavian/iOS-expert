//
//  GameProtocolForFavorites.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//
import Foundation

protocol GameProtocolForFavorites: Identifiable, Equatable, Codable {
    var id: Int { get }
    var name: String { get }
    var backgroundImageURL: URL? { get }
    var released: Date? { get }
    var rating: Double { get }
    var slug: String { get }
}



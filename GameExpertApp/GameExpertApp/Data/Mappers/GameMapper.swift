//
//  GameMapper.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Foundation

struct GameMapper {
    static func mapGameDTOToDomain(_ dto: GameDTO) -> Game {
        let dateFormatter = ISO8601DateFormatter()
        let releasedDate = dateFormatter.date(from: dto.released)
        let backgroundImageURL = URL(string: dto.backgroundImage)

        return Game(
            id: dto.id,
            name: dto.name,
            released: releasedDate,
            backgroundImageURL: backgroundImageURL,
            rating: dto.rating,
            platforms: dto.platforms.map { $0.platform.name },
            genres: dto.genres.map { $0.name },
            slug: dto.slug
        )
    }

    static func mapDomainToGameDTO(_ domain: Game) -> GameDTO {
        fatalError("Mapping from Domain to DTO for saving/sending is not fully implemented in this example.")
    }

    static func mapGameDTOsToDomain(_ dtos: [GameDTO]) -> [Game] {
        return dtos.map(mapGameDTOToDomain)
    }
}

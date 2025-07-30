//
//  GameDetailMapper.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Foundation
import Core

public struct GameDetailMapper {
    static func mapGameDetailDTOToDomain(_ dto: GameDetailDTO) -> GameDetail {
        let dateFormatter = ISO8601DateFormatter()
        let releasedDate = dto.released.flatMap { dateFormatter.date(from: $0) }
        let backgroundImageURL = dto.backgroundImage.flatMap { URL(string: $0) }
        let websiteURL = dto.website.flatMap { URL(string: $0) }

        return GameDetail(
            id: dto.id,
            name: dto.name ?? "",
            description: dto.description ?? "",
            released: releasedDate,
            backgroundImageURL: backgroundImageURL,
            rating: dto.rating,
            platforms: dto.platforms.map { $0.platform.name },
            genres: dto.genres.map { $0.name },
            websiteURL: websiteURL,
            developers: dto.developers.map { $0.name },
            publishers: dto.publishers.map { $0.name },
            slug: dto.slug ?? ""
        )
    }
}

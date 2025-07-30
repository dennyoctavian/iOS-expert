//
//  GameDetailDTO.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

// Data/Models/GameDetailDTO.swift
import Foundation

// MARK: - GameDetailDTO
public struct GameDetailDTO: Codable {
    let id: Int
    let slug, name, nameOriginal, description: String? // 'description' made optional for robustness
    let released: String?
    let tba: Bool
    let backgroundImage, backgroundImageAdditional: String?
    let website: String?
    let rating: Double
    let ratingTop: Int
    let ratings: [RatingDTO]
    let reactions: [String: Int]?
    let added: Int
    let addedByStatus: AddedByStatusDTO
    let playtime, screenshotsCount, moviesCount, creatorsCount: Int
    let achievementsCount, parentAchievementsCount: Int
    let redditUrl: String?
    let redditName, redditDescription, redditLogo: String?
    let metacritic: Int?
    let metacriticPlatforms: [MetacriticPlatformDTO]? // This was the main culprit
    let parentsCount, additionsCount, gameSeriesCount: Int
    let reviewsCount: Int
    let saturatedColor, dominantColor: String
    let parentPlatforms: [ParentPlatformDTO]
    let platforms: [PlatformElementDTO]
    let stores: [StoreDTO]
    let developers: [GenreDTO]
    let genres: [GenreDTO]
    let tags: [GenreDTO]
    let publishers: [GenreDTO]
    let esrbRating: EsrbRatingDTO?
    let updated: String
    let redditCount: Int?
    let twitchCount: Int?
    let youtubeCount: Int?
    let reviewsTextCount: Int?
    let ratingsCount: Int?
    let suggestionsCount: Int?
    let alternativeNames: [String]?
    let metacriticUrl: String?
    let userGame: JSONNull?


    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case nameOriginal = "name_original"
        case description, released, tba
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating
        case ratingTop = "rating_top"
        case ratings, reactions, added
        case addedByStatus = "added_by_status"
        case playtime
        case screenshotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
        case achievementsCount = "achievements_count"
        case parentAchievementsCount = "parent_achievements_count"
        case redditUrl = "reddit_url"
        case redditName = "reddit_name"
        case redditDescription = "reddit_description"
        case redditLogo = "reddit_logo"
        case metacritic
        case metacriticPlatforms = "metacritic_platforms"
        case parentsCount = "parents_count"
        case additionsCount = "additions_count"
        case gameSeriesCount = "game_series_count"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
        case platforms, stores, developers, genres, tags, publishers
        case esrbRating = "esrb_rating"
        case updated
        case redditCount = "reddit_count"
        case twitchCount = "twitch_count"
        case youtubeCount = "youtube_count"
        case reviewsTextCount = "reviews_text_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case alternativeNames = "alternative_names"
        case metacriticUrl = "metacritic_url"
        case userGame = "user_game"
    }
}

public struct MetacriticPlatformDTO: Codable {
    let metascore: Int
    let url: String
    let platform: MetacriticSubPlatformDTO
}

public struct MetacriticSubPlatformDTO: Codable {
    let platform: Int
    let name: String
    let slug: String
}

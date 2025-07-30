//
//  GameDTO.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Foundation

struct GameResponseDTO: Codable {
    let count: Int
    let next: String?
    let previous: JSONNull?
    let results: [GameDTO]
    let seoTitle, seoDescription, seoKeywords, seoH1: String
    let noindex, nofollow: Bool
    let description: String
    let filters: FiltersDTO
    let nofollowCollections: [String]

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow, description, filters
        case nofollowCollections = "nofollow_collections"
    }
}

struct FiltersDTO: Codable {
    let years: [FiltersYearDTO]
}

struct FiltersYearDTO: Codable {
    let from, to: Int
    let filter: String
    let decade: Int
    let years: [YearYearDTO]
    let nofollow: Bool
    let count: Int
}

struct YearYearDTO: Codable {
    let year, count: Int
    let nofollow: Bool
}

struct GameDTO: Codable, Identifiable {
    let id: Int
    let slug, name, released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let ratings: [RatingDTO]
    let ratingsCount, reviewsTextCount, added: Int
    let addedByStatus: AddedByStatusDTO
    let metacritic, playtime, suggestionsCount: Int
    let updated: String
    let userGame: JSONNull?
    let reviewsCount: Int
    let saturatedColor, dominantColor: ColorDTO
    let platforms: [PlatformElementDTO]
    let parentPlatforms: [ParentPlatformDTO]
    let genres: [GenreDTO]
    let stores: [StoreDTO]
    let clip: JSONNull?
    let tags: [GenreDTO]
    let esrbRating: EsrbRatingDTO
    let shortScreenshots: [ShortScreenshotDTO]

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case platforms
        case parentPlatforms = "parent_platforms"
        case genres, stores, clip, tags
        case esrbRating = "esrb_rating"
        case shortScreenshots = "short_screenshots"
    }
}

struct AddedByStatusDTO: Codable {
    let yet, owned, beaten, toplay: Int
    let dropped, playing: Int
}

enum ColorDTO: String, Codable {
    case the0F0F0F = "0f0f0f"
}

struct EsrbRatingDTO: Codable {
    let id: Int
    let name, slug: String
}

struct GenreDTO: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: DomainDTO?
    let language: LanguageDTO?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}

enum DomainDTO: String, Codable {
    case appsAppleCOM = "apps.apple.com"
    case epicgamesCOM = "epicgames.com"
    case gogCOM = "gog.com"
    case marketplaceXboxCOM = "marketplace.xbox.com"
    case microsoftCOM = "microsoft.com"
    case nintendoCOM = "nintendo.com"
    case playGoogleCOM = "play.google.com"
    case storePlaystationCOM = "store.playstation.com"
    case storeSteampoweredCOM = "store.steampowered.com"
}

enum LanguageDTO: String, Codable {
    case eng = "eng"
}

struct ParentPlatformDTO: Codable {
    let platform: EsrbRatingDTO
}

struct PlatformElementDTO: Codable {
    let platform: PlatformPlatformDTO
    let releasedAt: String
    let requirementsEn, requirementsRu: RequirementsDTO?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }
}

struct PlatformPlatformDTO: Codable {
    let id: Int
    let name, slug: String
    let image, yearEnd: JSONNull?
    let yearStart: Int?
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

struct RequirementsDTO: Codable {
    let minimum: String
    let recommended: String?
}

struct RatingDTO: Codable {
    let id: Int
    let title: TitleDTO
    let count: Int
    let percent: Double
}

enum TitleDTO: String, Codable {
    case exceptional = "exceptional"
    case meh = "meh"
    case recommended = "recommended"
    case skip = "skip"
}

struct ShortScreenshotDTO: Codable {
    let id: Int
    let image: String
}

struct StoreDTO: Codable {
    let id: Int
    let store: GenreDTO
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

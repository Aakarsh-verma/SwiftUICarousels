//
//  AnimeResponseModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/05/25.
//

import Foundation

/// continue accessing `response.data` as `[AnimeData]`.
struct AnimeResponseModel: Decodable {
    var pagination: Pagination?
    var data: [AnimeData]?

    private enum CodingKeys: String, CodingKey {
        case data
        case paging
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let wrappedData = try container.decodeIfPresent([MALAnimeNode].self, forKey: .data)
        data = wrappedData?.map { wrapper in
            var anime = wrapper.node
            // Ranking endpoints return the ranking separately from the node.
            if anime.rank == nil {
                anime.rank = wrapper.ranking?.rank
            }
            return anime
        }
        pagination = try container.decodeIfPresent(Pagination.self, forKey: .paging)
    }
}

// MARK: - MALAnimeNode

private struct MALAnimeNode: Decodable {
    var node: AnimeData
    var ranking: MALRanking?
}

private struct MALRanking: Decodable {
    var rank: Int?
}

// MARK: - AnimeData
struct AnimeData: Decodable, Identifiable, Encodable {
    let id: Int?
    let url: String?
    let images: AnimeImage?
    let titles: AlternativeTitles?
    let title, titleEnglish, titleJapanese: String?
    let type, source: String?
    let episodes: Int?
    var rank: Int?
    let startDate, endDate, status: String?
    let rating: String?
    let score: Double?
    let scoredBy, popularity: Int?
    let startSeason: SeasonDetails?
    let synopsis, season: String?
    let year: Int?
    let broadcast: Broadcast?
    let studios, genres: [Demographic]?

    // Additional MAL fields that do not have direct Jikan equivalents.
    var createdAt: String?
    var updatedAt: String?
    var averageEpisodeDuration: Int?

    private enum CodingKeys: String, CodingKey {
        case id, title
        case synopsis, broadcast
        case score = "mean"
        case rank, popularity, rating
        case status, genres, source, studios
        case images = "main_picture"
        case titles = "alternative_titles"
        case startDate = "start_date"
        case endDate = "end_date"
        case scoredBy = "num_scoring_users"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case type = "media_type"
        case episodes = "num_episodes"
        case startSeason = "start_season"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        // MARK: Image compatibility
        images = try container.decodeIfPresent(AnimeImage.self, forKey: .images)
        // MARK: Alternative titles
        titles = try container.decodeIfPresent(AlternativeTitles.self, forKey: .titles)
        titleEnglish = titles?.english
        titleJapanese = titles?.japanese
        // MARK: Basic information
        type = try container.decodeIfPresent(String.self, forKey: .type)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        episodes = try container.decodeIfPresent(Int.self, forKey: .episodes)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        rating = try container.decodeIfPresent(String.self, forKey: .rating)
        score = try container.decodeIfPresent(Double.self, forKey: .score)
        // MARK: Ranking and popularity
        scoredBy = try container.decodeIfPresent(Int.self, forKey: .scoredBy)
        rank = try container.decodeIfPresent(Int.self, forKey: .rank)
        popularity = try container.decodeIfPresent(Int.self, forKey: .popularity)
        // MARK: Description
        synopsis = try container.decodeIfPresent(String.self, forKey: .synopsis)
        // MARK: Dates
        startDate = try container.decodeIfPresent(String.self, forKey: .startDate)
        endDate = try container.decodeIfPresent(String.self, forKey: .endDate)
        // MARK: Season
        startSeason = try container.decodeIfPresent(SeasonDetails.self, forKey: .startSeason)
        season = startSeason?.season
        year = startSeason?.year
        // MARK: Broadcast
        broadcast = try container.decodeIfPresent(Broadcast.self, forKey: .broadcast)
        // MARK: Related data
        studios = try container.decodeIfPresent([Demographic].self, forKey: .studios)
        genres = try container.decodeIfPresent([Demographic].self, forKey: .genres)
        // MARK: Additional MAL information
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        // Fields unavailable from MAL v2's anime object.
        url = id.map { "https://myanimelist.net/anime/\($0)" }
    }
}

// MARK: - AlternativeTitles
struct AlternativeTitles: Decodable, Encodable {
    var synonyms: [String]?
    var english: String?
    var japanese: String?

    private enum CodingKeys: String, CodingKey {
        case synonyms
        case english = "en"
        case japanese = "ja"
    }
}

// MARK: - SeasonDetails
struct SeasonDetails: Decodable, Encodable {
    var year: Int?
    var season: String?
}

// MARK: - Broadcast
struct Broadcast: Decodable, Encodable {
    var day: String?
    var time: String?
    var timezone: String?
    var string: String?

    private enum CodingKeys: String, CodingKey {
        case day = "day_of_the_week"
        case time = "start_time"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        day = try container.decodeIfPresent(String.self, forKey: .day)
        time = try container.decodeIfPresent(String.self, forKey: .time)
        // MAL's broadcast time is documented as JST.
        timezone = time == nil ? nil : "Asia/Tokyo"
        if let day, let time {
            string = "\(day.capitalized) at \(time) JST"
        } else {
            string = day?.capitalized ?? time
        }
    }
}

// MARK: - Demographic
struct Demographic: Decodable, Encodable {
    var name: String?
    var id: Int?
}

// MARK: - AnimeImage
struct AnimeImage: Decodable, Encodable {
    var mediumImageURL: String?
    var largeImageURL: String?

    private enum CodingKeys: String, CodingKey {
        case mediumImageURL = "medium"
        case largeImageURL = "large"
    }
}

// MARK: - Pagination
struct Pagination: Decodable, Encodable {
    var previousURL: String?
    var nextURL: String?

    private enum CodingKeys: String, CodingKey {
        case previousURL = "previous"
        case nextURL = "next"
    }
}

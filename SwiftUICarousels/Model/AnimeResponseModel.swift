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
struct AnimeData: Decodable, Identifiable {
    var malID: Int?
    var url: String?
    var images: [String: AnimeImage]?
    var title, titleEnglish, titleJapanese: String?
    var type, source: String?
    var episodes: Int?
    var startDate, endDate, status: String?
    var rating: String?
    var score: Double?
    var scoredBy, rank, popularity: Int?
    var synopsis, season: String?
    var year: Int?
    var broadcast: Broadcast?
    var studios, genres: [Demographic]?

    // Additional MAL fields that do not have direct Jikan equivalents.
    var createdAt: String?
    var updatedAt: String?
    var averageEpisodeDuration: Int?

    var id: Int { malID ?? 0 }

    private enum CodingKeys: String, CodingKey {
        case id, title
        case synopsis, broadcast
        case mean, rank, popularity, rating
        case status, genres, source, studios
        case mainPicture = "main_picture"
        case alternativeTitles = "alternative_titles"
        case startDate = "start_date"
        case endDate = "end_date"
        case numScoringUsers = "num_scoring_users"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case mediaType = "media_type"
        case numEpisodes = "num_episodes"
        case startSeason = "start_season"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        malID = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        // MARK: Image compatibility
        if let mainPicture = try container.decodeIfPresent(AnimeImage.self, forKey: .mainPicture) {
            images = ["jpg": mainPicture, "webp": mainPicture]
        } else {
            images = nil
        }
        // MARK: Alternative titles
        let alternativeTitles = try container.decodeIfPresent(AlternativeTitles.self, forKey: .alternativeTitles)
        titleEnglish = alternativeTitles?.english
        titleJapanese = alternativeTitles?.japanese
        // MARK: Basic information
        type = try container.decodeIfPresent(String.self, forKey: .mediaType)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        episodes = try container.decodeIfPresent(Int.self, forKey: .numEpisodes)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        rating = try container.decodeIfPresent(String.self, forKey: .rating)
        score = try container.decodeIfPresent(Double.self, forKey: .mean)
        // MARK: Ranking and popularity
        scoredBy = try container.decodeIfPresent(Int.self, forKey: .numScoringUsers)
        rank = try container.decodeIfPresent(Int.self, forKey: .rank)
        popularity = try container.decodeIfPresent(Int.self, forKey: .popularity)
        // MARK: Description
        synopsis = try container.decodeIfPresent(String.self, forKey: .synopsis)
        // MARK: Dates
        startDate = try container.decodeIfPresent(String.self, forKey: .startDate)
        endDate = try container.decodeIfPresent(String.self, forKey: .endDate)
        // MARK: Season
        let startSeason = try container.decodeIfPresent(StartSeason.self, forKey: .startSeason)
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
        url = malID.map { "https://myanimelist.net/anime/\($0)" }
    }
}

// MARK: - AlternativeTitles
private struct AlternativeTitles: Decodable {
    var synonyms: [String]?
    var english: String?
    var japanese: String?

    private enum CodingKeys: String, CodingKey {
        case synonyms
        case english = "en"
        case japanese = "ja"
    }
}

// MARK: - StartSeason
private struct StartSeason: Decodable {
    var year: Int?
    var season: String?
}

// MARK: - Broadcast
struct Broadcast: Decodable {
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
struct Demographic: Decodable {
    var name: String?
    var id: Int?
}

// MARK: - AnimeImage
struct AnimeImage: Decodable {
    var imageURL: String?
    var smallImageURL: String?
    var largeImageURL: String?

    private enum CodingKeys: String, CodingKey {
        case medium
        case large
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let medium = try container.decodeIfPresent(String.self, forKey: .medium)
        let large = try container.decodeIfPresent(String.self, forKey: .large)
        imageURL = medium ?? large
        smallImageURL = medium ?? large
        largeImageURL = large ?? medium
    }
}

// MARK: - Images
struct Images: Decodable {
    var imageURL, smallImageURL, mediumImageURL, largeImageURL: String?
    var maximumImageURL: String?

    private enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case mediumImageURL = "medium_image_url"
        case largeImageURL = "large_image_url"
        case maximumImageURL = "maximum_image_url"
    }
}

// MARK: - Pagination
struct Pagination: Decodable {
    var previousURL: String?
    var nextURL: String?

    private enum CodingKeys: String, CodingKey {
        case previousURL = "previous"
        case nextURL = "next"
    }
}

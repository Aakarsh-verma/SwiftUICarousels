//
//  AnimeResponseModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/05/25.
//

import Foundation

// MARK: - AnimeResponse
struct AnimeResponseModel: Codable {
    var pagination: Pagination?
    var data: [AnimeData]?
}

// MARK: - AnimeData
struct AnimeData: Codable {
    var malID: Int?
    var url: String?
    var images: [String: Image]?
    var trailer: Trailer?
    var approved: Bool?
    var titles: [Title]?
    var title, titleEnglish, titleJapanese: String?
    var titleSynonyms: [String]?
    var type, source: String?
    var episodes: Int?
    var status: String?
    var airing: Bool?
    var aired: Aired?
    var duration, rating: String?
    var score: Double?
    var scoredBy, rank, popularity, members: Int?
    var favorites: Int?
    var synopsis, background, season: String?
    var year: Int?
    var broadcast: Broadcast?
    var producers, licensors, studios, genres: [Demographic]?
    var explicitGenres: [String]?
    var themes, demographics: [Demographic]?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url, images, trailer, approved, titles, title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case titleSynonyms = "title_synonyms"
        case type, source, episodes, status, airing, aired, duration, rating, score
        case scoredBy = "scored_by"
        case rank, popularity, members, favorites, synopsis, background, season, year, broadcast, producers, licensors, studios, genres
        case explicitGenres = "explicit_genres"
        case themes, demographics
    }
}

// MARK: - Aired
struct Aired: Codable {
    var from, to: String?
    var prop: Prop?
    var string: String?
}

// MARK: - Prop
struct Prop: Codable {
    var from, to: From?
}

// MARK: - From
struct From: Codable {
    var day, month, year: Int?
}

// MARK: - Broadcast
struct Broadcast: Codable {
    var day, time, timezone, string: String?
}

// MARK: - Demographic
struct Demographic: Codable {
    var malID: Int?
    var type: TypeEnum?
    var name: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case type, name, url
    }
}

enum TypeEnum: String, Codable {
    case anime = "anime"
}

// MARK: - Image
struct Image: Codable {
    var imageURL, smallImageURL, largeImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

// MARK: - Title
struct Title: Codable {
    var type, title: String?
}

// MARK: - Trailer
struct Trailer: Codable {
    var youtubeID: String?
    var url, embedURL: String?
    var images: Images?

    enum CodingKeys: String, CodingKey {
        case youtubeID = "youtube_id"
        case url
        case embedURL = "embed_url"
        case images
    }
}

// MARK: - Images
struct Images: Codable {
    var imageURL, smallImageURL, mediumImageURL, largeImageURL: String?
    var maximumImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case mediumImageURL = "medium_image_url"
        case largeImageURL = "large_image_url"
        case maximumImageURL = "maximum_image_url"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    var lastVisiblePage: Int?
    var hasNextPage: Bool?
    var currentPage: Int?
    var items: Items?

    enum CodingKeys: String, CodingKey {
        case lastVisiblePage = "last_visible_page"
        case hasNextPage = "has_next_page"
        case currentPage = "current_page"
        case items
    }
}

// MARK: - Items
struct Items: Codable {
    var count, total, perPage: Int?

    enum CodingKeys: String, CodingKey {
        case count, total
        case perPage = "per_page"
    }
}

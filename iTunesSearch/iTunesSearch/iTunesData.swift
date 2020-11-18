//
//  iTunesSearchData.swift
//  iTunesSearch
//
//  Created by Karthick Chandran on 6/4/20.
//  Copyright © 2020 Karthick Chandran. All rights reserved.
//

import Foundation
struct iTunesData: Codable {
    let resultCount: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let wrapperType: String
    let kind: String?
    let artistID, collectionID, trackID: Int?
    let artistName: String
    let collectionName, trackName, collectionCensoredName, trackCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: Country?
    let currency: Currency?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let collectionArtistName: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable, collectionArtistName
    }
}


enum Explicitness: String, Codable {
    case notExplicit = "notExplicit"
}

enum Country: String, Codable {
    case usa = "USA"
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum Kind: String, Codable {
//     [book, album, coached-audio, feature- movie, interactive- booklet, music-video, pdf podcast, podcast-episode, software- package, song, tv- episode, artist]
    case noValue = ""
    case song = "Song"
    case featureMovie = "Feature-movie"
    case podcast = "Podcast"
    case book = "Book"
    case album = "Album"
    case coachedAudio = "Coached-audio"
    case interactiveBooklet = "Interactive-booklet"
    case musicVideo = "Music-video"
    case pdf = "Pdf"
    case podcastEpisode = "Podcast-episode"
    case softwarePackage = "Software-package"
    case tvEpisode = "Tv-episode"
    case artist = "Artist"
    
}

enum PrimaryGenreName: String, Codable {
    case alternative = "Alternative"
    case rock = "Rock"
}

enum WrapperType: String, Codable {
    case track = "track"
}
struct iTunesDisplayData {
    var kind: String?
    var artistName: String
    var previewURL:String
    var primaryGenreName:String
    var artworkUrl30, artworkUrl60, artworkUrl100: String?
    
    enum CodingKeys: String, CodingKey {
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100
    }
    init() {
        self.artistName = String()
        self.previewURL = String()
        self.primaryGenreName = String()
    }
}

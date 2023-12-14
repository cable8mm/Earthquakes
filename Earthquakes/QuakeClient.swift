//
//  QuakeClient.swift
//  Earthquakes
//
//  Created by samgu.lee on 14/12/23.
//

import Foundation

class QuakeClient {
    private let quakeCache: NSCache<NSString, CacheEntryObject> = NSCache()

    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()

    private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!

    private let downloader: any HTTPDataDownloader

    var quakes: [Quake] {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let allQuakes = try decoder.decode(GeoJSON.self, from: data)
            return allQuakes.quakes
        }
    }
    
    init(downloader: HTTPDataDownloader) {
        self.downloader = downloader
    }
}

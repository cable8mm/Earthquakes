//
//  HTTPDataDownloader.swift
//  Earthquakes
//
//  Created by samgu.lee on 14/12/23.
//

import Foundation

let validStatus = 200...299

protocol HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
            validStatus.contains(response.statusCode)
        else {
            throw QuakeError.networkError
        }
        return data
    }
}

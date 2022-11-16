//
//  AdsDataService.swift
//  NetworkLayer
//
//  Created by Pierre on 15/11/2022.
//

import Foundation

class AdsDataService {
    let session: URLSession
    
    var urlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
    
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }

    func fetchAds() async throws -> [Ad] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badUrl
        }

        let urlRequest = URLRequest(url: url)
        let (data, response) = try await session.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.serverError
        }

        let decodedAds = try JSONDecoder().decode([Ad].self, from: data)
        return decodedAds
    }
}

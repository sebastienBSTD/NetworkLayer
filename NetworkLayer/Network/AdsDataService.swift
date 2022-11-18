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

        let result = try await NetworkHelper.network(url: url, session: session)
        try NetworkHelper.handleResponse(response: result.response)
        return try NetworkHelper.decode(data: result.data)
    }
}

//
//  NetworkHelper.swift
//  NetworkLayer
//
//  Created by Pierre on 18/11/2022.
//

import Foundation

class NetworkHelper {
    static func network(url: URL, session: URLSession) async throws -> (data: Data, response: URLResponse) {
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await session.data(for: urlRequest)
        return (data, response)
    }
    
    static func handleResponse(response: URLResponse) throws {
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.serverError
        }
    }
    
    static func decode<T: Decodable>(data: Data) throws -> T {
        let decodedAds = try JSONDecoder().decode(T.self, from: data)
        return decodedAds
    }
}

//
//  URLSessionHTTPClient.swift
//  NetworkLayer
//
//  Created by Nicolas Demange on 12/01/2023.
//

import Foundation

protocol HTTPClient {
    func data(from url: URL) async throws -> (Data, HTTPURLResponse)
}

final class URLSessionHTTPClient: HTTPClient {

    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func data(from url: URL) async throws -> (Data, HTTPURLResponse) {
        guard let (data, response) = try? await session.data(from: url), let response = response as? HTTPURLResponse else {
            throw URLError(.notConnectedToInternet)
        }
        return (data, response)
    }

}

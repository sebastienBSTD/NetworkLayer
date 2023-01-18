//
//  CategoriesLoader.swift
//  NetworkLayer
//
//  Created by Nicolas Demange on 17/01/2023.
//

import Foundation

final class CategoriesLoader {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load(from url: URL) async throws -> [CategoryItem] {
        let (data, response) = try await client.data(from: url)
        return try CategoryItemsMapper.map(data, from: response)
    }
}

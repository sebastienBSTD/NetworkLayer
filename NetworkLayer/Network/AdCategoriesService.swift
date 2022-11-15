//
//  AdCategoriesService.swift
//  NetworkLayer
//
//  Created by Pierre on 15/11/2022.
//

import Foundation

class AdCategoriesService {
    var urlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"
    
    func fetchCategory() async throws -> [Category] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badUrl
        }

        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.serverError
        }

        let decodedCategories = try JSONDecoder().decode([Category].self, from: data)
        return decodedCategories
    }
}

//
//  AdCategoriesService.swift
//  NetworkLayer
//
//  Created by Pierre on 15/11/2022.
//

import Foundation

class AdCategoriesService {
    let session: URLSession
    
    var urlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"
    
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    
    func fetchCategory() async throws -> [Category] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badUrl
        }
        
        let result = try await NetworkHelper.network(url: url, session: session)
        try NetworkHelper.handleResponse(response: result.response)
        return try NetworkHelper.decode(data: result.data)
    }
}

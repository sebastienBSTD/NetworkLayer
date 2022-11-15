//
//  AdsDataService.swift
//  NetworkLayer
//
//  Created by Pierre on 15/11/2022.
//

import Foundation

class AdsDataService {
    var urlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"

    func fetchAds() async throws -> [Ad] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badUrl
        }

        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.serverError
        }

        let decodedAds = try JSONDecoder().decode([Ad].self, from: data)
        return decodedAds
    }
    
    // fetchAds(url: URL déjé debale)
    // fct decodage (model, data)
    // class qui gere l'appel réseau, 2 appel reseau
    // protocole pas sur le service
    // test
    // tdd test de comportement: status 200 ou ..., data, simuler pas de connexion
}

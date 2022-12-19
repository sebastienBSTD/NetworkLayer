//
//  Service.swift
//  NetworkLayer
//
//  Created by Nicolas Demange on 15/12/2022.
//

import Foundation

// MARK: - Protocol

protocol AdService {
    
    func fetchAdWithAsync() async throws
    
}

// MARK: - Class

final class AdSession: AdService {

    // MARK: - Properties

    
    // MARK: - Initializer
    
    
    // MARK: - Methods
    
    func fetchAdWithAsync() async throws {
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else  { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        let decodedAd = try JSONDecoder().decode(Ad.self, from: data)
        print("-> \(decodedAd)")
    }
    
}

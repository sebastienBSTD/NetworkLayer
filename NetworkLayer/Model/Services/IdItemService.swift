//
//  IdAdService.swift
//  NetworkLayer
//
//  Created by Nicolas Demange on 18/12/2022.
//

import Foundation

// MARK: - Protocol

protocol ItemService {
    
    func fetchItemWithAsync() async throws
    
}

// MARK: - Class

final class ItemSession: ItemService {

    // MARK: - Properties

    
    // MARK: - Initializer
    
    
    // MARK: - Methods
    
    func fetchItemWithAsync() async throws {
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json") else  { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        let decodedItem = try JSONDecoder().decode(Item.self, from: data)
        print("-> \(decodedItem)")
    }
    
}



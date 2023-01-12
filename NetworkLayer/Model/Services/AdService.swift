////
////  Service.swift
////  NetworkLayer
////
////  Created by Nicolas Demange on 15/12/2022.
////
//
//import Foundation
//
//// MARK: - Protocol
//
//
//final class AdSession {
//
//    // MARK: - Properties
//
//    
//    // MARK: - Initializer
//    
//    
//    // MARK: - Methods
//    
//    func parseURL(url: URL) async throws {
//        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else  { NetworkError.undecodableData }
//        let urlRequest = URLRequest(url: url)
//    }
//    
//    
//    func fetchAdWithAsync(url: URL) async throws {
//        do {
//            let ads = try await fetchAdWithAsync(url: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")
//        } catch {
//            
//        }
//    }
//        
//        
//        //
////        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else  { throw NSError() }
////        let urlRequest = URLRequest(url: url)
//        //
//        
//        //
//        let (data, response) = try await URLSession.shared.data(from: url)
//        //
//        
//        //
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.noResponse }
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        let decodedAd = try decoder.decode(Ad.self, from: data)
//        //
//    }
//    
//}

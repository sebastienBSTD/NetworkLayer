//
//  CoreAdvertsService.swift
//  NetworkLayer
//
//  Created by Clément Garcia on 17/10/2022.
//

import Foundation

/// Handle the services related to adverts
final class CoreAdvertsService {
    
    // MARK: - Vars
    /// URLSession handling the call to the REST apis
    private let session: URLSession
    /// Service to handle the categories used within adverts
    private let categoryService = CoreCategoryService()
    
    // MARK: - initializer
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Function
    /// Retreive the list of adverts
    /// - Returns: List of adverts
    func getAdvertsList() async throws -> AdvertsList {
        let (data, _) = try await session.data(from: ApiEndpoint.getEndpointAdvert())
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(AdvertsList.self, from: data)
    }
    
    /// Display details of an advert through the console
    /// - Parameter advert: Affected advert to display
    func displayAdvert(for advert: AdvertsListElement) async{
        print("""
--------------------------------Annonce \(advert.id)--------------------------------
Titre: \(advert.title)
Identifiant: \(advert.id)
Category Id : \(advert.categoryId ?? 9999)
Category Title: \(await categoryService.getCategoryPerID(advert.categoryId ?? 9999))
Description: \(advert.description ?? "Aucune description disponible")
Prix: \(advert.price)€
--------------------------------------------------------------------------------------
""")
    }
}

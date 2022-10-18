//
//  CoreCategoryService.swift
//  NetworkLayer
//
//  Created by Clément Garcia on 17/10/2022.
//

import Foundation

final class CoreCategoryService {
    
    // MARK: - Vars
    /// URLSession handling the call to the REST apis
    private let session: URLSession
    
    // MARK: - initializer
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Retreive the categories list
    /// - Returns: List of category
    func getCategoryList() async throws -> CategoryList {
        let (data, _) = try await session.data(from: ApiEndpoint.getEndpointCategory())
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(CategoryList.self, from: data)
    }
    
    /// Provide the category name based on the category ID provided
    /// - Parameter idCategory: Id of the category looked for
    /// - Returns: Category name. Otherwise  return "Indisponible" if ID isn't found
    func getCategoryPerID(_ idCategory: Int) async -> String {
        var categoryList: CategoryList
        let unknownCategoryTitle = "Indisponible"
        do {
            categoryList = try await getCategoryList()
        } catch {
            return unknownCategoryTitle
        }
        let filteredList = categoryList.filter { $0.id == idCategory }
        guard filteredList.count > 0 else { return unknownCategoryTitle }
        return filteredList.first?.name ?? unknownCategoryTitle
    }
}

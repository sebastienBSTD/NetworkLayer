//
//  CategoryItemsMapper.swift
//  NetworkLayer
//
//  Created by Nicolas Demange on 17/01/2023.
//

import Foundation

struct CategoryItemsMapper {
    private struct RemoteCategoryItem: Decodable {
        let id: Int
        let name: String
        
        var categoryItem: CategoryItem {
            CategoryItem(id: id, name: name)
        }
    }
    
    enum Error: Swift.Error {
        case invalidData
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [CategoryItem] {
        guard response.statusCode == 200, let root = try? JSONDecoder().decode([RemoteCategoryItem].self, from: data) else {
            throw Error.invalidData
        }
        return root.map { $0.categoryItem }
    }
}

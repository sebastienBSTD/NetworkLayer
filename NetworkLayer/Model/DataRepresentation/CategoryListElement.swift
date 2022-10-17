//
//  CategoryListElement.swift
//  NetworkLayer
//
//  Created by Clément Garcia on 17/10/2022.
//

/// Descibe an element of the categories list
struct CategoryListElement: Decodable {
    let id: Int
    let name: String
}

typealias CategoryList = [CategoryListElement]

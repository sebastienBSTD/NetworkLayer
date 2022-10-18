//
//  AdvertsListElement.swift
//  NetworkLayer
//
//  Created by Clément Garcia on 17/10/2022.
//

import Foundation

/// Descibe an element of the adverts list
struct AdvertsListElement: Codable {
    let id: Int
    let categoryId: Int?
    let title: String
    let description: String?
    let price: Int
    let imagesURL: ImagesURL?
    let creationDate: String?
    let isUrgent: Bool?
    let siret: String?
}

// MARK: - ImagesURL
struct ImagesURL: Codable {
    let small, thumb: String?
}

typealias AdvertsList = [AdvertsListElement]



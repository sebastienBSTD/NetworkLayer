//
//  Ad.swift
//  NetworkLayer
//
//  Created by Pierre on 15/11/2022.
//

import Foundation

struct Ad: Codable {
    let id, categoryID: Int
    let title, description: String
    let price: Int
    let imagesURL: ImagesURL
    let creationDate: Date
    let isUrgent: Bool
    let siret: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case description = "description"
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
}

struct ImagesURL: Codable {
    let small, thumb: String?
}

//
//  Ads.swift
//  NetworkLayer
//
//  Created by Nicolas Demange on 15/12/2022.
//

import Foundation

// MARK: - Ad

struct Ad: Identifiable, Decodable {
    let id, categoryID: Int
    let title, adDescription: String
    let price: Int
    let imagesURL: ImagesURL
    let creationDate: Date
    let isUrgent: Bool
    let siret: String?
}

// MARK: - ImagesURL

struct ImagesURL: Decodable {
    let small, thumb: String?
}

typealias Ads = [Ad]

//
//  Items.swift
//  NetworkLayer
//
//  Created by Nicolas Demange on 15/12/2022.
//

import Foundation

// MARK: - Item

struct Item: Codable {
    let id: Int
    let name: String
}

typealias Items = [Item]

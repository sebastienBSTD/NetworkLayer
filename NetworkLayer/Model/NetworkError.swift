//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Nicolas Demange on 28/12/2022.
//

import Foundation

enum NetworkError: Error {
    case noResponse
    case notConnectedToInternet
    case undecodableData
}

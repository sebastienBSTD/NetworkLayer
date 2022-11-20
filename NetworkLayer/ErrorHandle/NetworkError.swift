//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Pierre on 15/11/2022.
//

import Foundation

enum NetworkError: Error {
    case badUrl, serverError
    
    var title: String {
        switch self {
        case .badUrl:
            return "Alert URL"
        case .serverError:
            return "Alert Network"
        }
    }
    
    var message: String {
        switch self {
        case .badUrl:
            return "[🔥] Bad URL"
        case .serverError:
            return "[🔥] Server Error"
        }
    }
}

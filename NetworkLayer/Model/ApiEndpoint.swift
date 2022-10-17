//
//  ApiEndpoint.swift
//  NetworkLayer
//
//  Created by Clément Garcia on 17/10/2022.
//

import Foundation

/// Handle the ends to generate based on user need
struct ApiEndpoint {
    // MARK: - Vars
    /// The endpoint to reach. (Part added after the api address. E.g.: myapi.com/path)
    var path: String
    /// Full url endpoint
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "raw.githubusercontent.com"
        components.path = "/" + path
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
}

// MARK: - Extension
extension ApiEndpoint {
    /// Return the endpoint to reach in order to retreive the categories list
    /// - Returns: Endpoint to reach
    static func getEndpointCategory() -> URL {
        let endpoint = ApiEndpoint(path: "leboncoin/paperclip/master/categories.json")
        return endpoint.url
    }
    
    /// Return the endpoint to reach in order to retreive the categories list
    /// - Returns: Endpoint to reach
    static func getEndpointAdvert() -> URL {
        let endpoint = ApiEndpoint(path: "leboncoin/paperclip/master/listing.json")
        return endpoint.url
    }
}

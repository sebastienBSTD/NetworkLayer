//
//  FakeResponseData.swift
//  NetworkLayerTests
//
//  Created by Clément Garcia on 17/10/2022.
//

import Foundation
@testable import NetworkLayer

final class FakeResponseData {
    
    // MARK: - URL
    static let endpointForAdverts: URL = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")!
    static let endpointForCategory: URL = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!
    
    // MARK: - Responses
    static let validResponseCode = HTTPURLResponse(url: URL(string: "https://www.apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let invalidResponseCode = HTTPURLResponse(url: URL(string: "https://www.apple.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - Data
    static var correctCategoryListData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        return bundle.dataFromJson("correctCategoryList")
    }
    
    static var correctAdvertsListData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        return bundle.dataFromJson("correctAdvertsList")
    }
    static let incorrectjsonData = "erreur".data(using: .utf8)!
}

// MARK: - Extensions related to Bundle
extension Bundle {
    
    /// Extract data from a json file
    /// - Parameter name: json file name
    /// - Returns: data
    func dataFromJson(_ name: String) -> Data {
        guard let mockURL = url(forResource: name, withExtension: "json"),
              let data = try? Data(contentsOf: mockURL) else {
            fatalError("Failed to load \(name) from bundle.")
        }
        return data
    }
}

//
//  FakeResponseCategoriesTestCase.swift
//  NetworkLayerTests
//
//  Created by Nicolas Demange on 12/01/2023.
//

import Foundation
@testable import NetworkLayer

class FakeResponseCategoriesTestCase: HTTPClient {

    static let url: URL = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!, statusCode: 200, httpVersion: .none, headerFields: .none)
    
    static let responseKO = HTTPURLResponse(url: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!, statusCode: 500, httpVersion: .none, headerFields: .none)
    
    func data(from url: URL) async throws -> (Data, HTTPURLResponse) {
        let result = try await data(from: url)

    }
    
    
}

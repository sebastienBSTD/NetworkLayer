//
//  FakeResponseDataCategories.swift
//  NetworkLayerTests
//
//  Created by Nicolas Demange on 12/01/2023.
//

import Foundation

class FakeResponseDataCategories {
    
    static let url: URL = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    
    static let responseKO = HTTPURLResponse(url: URL(string: "http://data.fixer.io/api/latest?access_key=2b1aed3ee194ffaad20c7989a8e58b7c&format=json")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    static var categoriesCorrectData: Data {
        let bundle = Bundle(for: FakeResponseDataCategories.self)
        let url = bundle.url(forResource: "IdList", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let categoriesIncorrectData = "erreur".data(using: .utf8)!
}

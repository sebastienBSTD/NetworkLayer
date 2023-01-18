//
//  SharedTestHelpers.swift
//  NetworkLayerTests
//
//  Created by Nicolas Demange on 17/01/2023.
//

import Foundation
@testable import NetworkLayer

func anyURL() -> URL {
    URL(string: "http://www.an-url.com")!
}

func anyNSError() -> NSError {
    NSError(domain: "error", code: 0)
}

func anyData() -> Data {
    Data("any data".utf8)
}

func anyHTTPURLResponse() -> HTTPURLResponse {
    HTTPURLResponse.init(url: anyURL(), statusCode: 200, httpVersion: .none, headerFields: .none)!
}

func nonHTTPURLResponse() -> URLResponse {
    URLResponse.init(url: anyURL(), mimeType: .none, expectedContentLength: 0, textEncodingName: .none)
}

func anySuccessHTTPResult(data: Data = anyData(), statusCode: Int = 200) -> Result<(Data, HTTPURLResponse), Error> {
    .success((data, HTTPURLResponse.init(statusCode: statusCode)))
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: .none, headerFields: .none)!
    }
}

func makeJSONItem(_ items: [[String: Any]]) -> Data {
    try! JSONSerialization.data(withJSONObject: items)
}

func makeCategoryItem(id: Int, name: String) -> (model: CategoryItem, json: [String: Any]) {
    let model = CategoryItem(id: id, name: name)
    let json: [String: Any] = [
        "id": id,
        "name": name
    ]
    return (model, json)
}

func makeListingItem(category_id: Int, title: String) -> (model: ListingLoader.Listing, json: [String: Any]) {
    let model = ListingLoader.Listing(category_id: category_id, title: title)
    let json: [String: Any] = [
        "category_id": category_id,
        "title": title
        ]
    return (model, json)
}

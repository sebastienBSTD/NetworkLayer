//
//  HTTPClientSpy.swift
//  NetworkLayerTests
//
//  Created by Nicolas Demange on 17/01/2023.
//

import Foundation
@testable import NetworkLayer

final class HTTPClientSpy: HTTPClient {
    private(set) var urls: [URL] = []
    private let result: Result<(Data, HTTPURLResponse), Error>
    
    init(result: Result<(Data, HTTPURLResponse), Error>) {
        self.result = result
    }
    
    func data(from url: URL) async throws -> (Data, HTTPURLResponse) {
        urls.append(url)
        return try result.get()
    }
}

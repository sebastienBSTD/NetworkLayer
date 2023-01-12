//
//  HTTPClientSpy.swift
//  NetworkLayerTests
//
//  Created by Nicolas Demange on 12/01/2023.
//

import Foundation
@testable import NetworkLayer

class HTTPClientSpy: HTTPClient {
    
    func data(from url: URL) async throws -> (Data, HTTPURLResponse) {
        return (Data(), HTTPURLResponse(url: URL(string: "")!, statusCode: 300, httpVersion: .none, headerFields: .none)!)
    }
    

}

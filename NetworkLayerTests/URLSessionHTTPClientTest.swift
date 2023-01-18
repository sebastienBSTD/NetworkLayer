//
//  URLSessionHTTPClientTest.swift
//  NetworkLayerTests
//
//  Created by Nicolas Demange on 12/01/2023.
//

import XCTest
@testable import NetworkLayer

final class URLSessionHTTPClientTest: XCTestCase {

    func test_data_failsOnAllInvalidRespresentationCase() async {
        await expectedErrorFor((data: .none, response: .none, error: anyNSError()))
        await expectedErrorFor((data: .none, response: nonHTTPURLResponse(), error: .none))
        await expectedErrorFor((data: anyData(), response: .none, error: anyNSError()))
        await expectedErrorFor((data: .none, response: .none, error: anyNSError()))
        await expectedErrorFor((data: .none, response: anyHTTPURLResponse(), error: anyNSError()))
        await expectedErrorFor((data: anyData(), response: nonHTTPURLResponse(), error: anyNSError()))
        await expectedErrorFor((data: anyData(), response: anyHTTPURLResponse(), error: anyNSError()))
        await expectedErrorFor((data: anyData(), response: nonHTTPURLResponse(), error: .none))
    }
    
    func test_data_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() async {
        await expectedValueFor((data: Data(), response: anyHTTPURLResponse(), error: .none))
    }
    
    func test_data_succeedsOnHTTPURLResponseWithData() async {
        await expectedValueFor((data: anyData(), response: anyHTTPURLResponse(), error: .none))
    }
    
    // MARK: - Helpers
    
    func makeSut() -> URLSessionHTTPClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolFake.self]
        let session = URLSession(configuration: configuration)
        let sut = URLSessionHTTPClient(session: session)
        return sut
    }
    
    private func expectedErrorFor(_ values: (data: Data?, response: URLResponse?, error: Error?)? = nil) async {
        values.map { URLProtocolFake.stub(data: $0, response: $1, error: $2) }
        let sut = makeSut()
        
        do {
            _ = try await sut.data(from: anyURL() )
            XCTFail("Expected no connection")
        } catch {
            XCTAssertEqual(error as! URLError, URLError(.notConnectedToInternet))
        }
    }
    
    private func expectedValueFor(_ values: (data: Data?, response: HTTPURLResponse?, error: Error?)? = nil) async {
        values.map { URLProtocolFake.stub(data: $0, response: $1, error: $2) }
        let sut = makeSut()
        
        do {
            let value: (data:Data, response: HTTPURLResponse) = try await sut.data(from: anyURL())
            XCTAssertEqual(value.data, values?.data)
            XCTAssertEqual(value.response.url, values?.response?.url)
            XCTAssertEqual(value.response.statusCode, values?.response?.statusCode)
        } catch {
            XCTFail("Expected data and response values")
        }
    }

}
